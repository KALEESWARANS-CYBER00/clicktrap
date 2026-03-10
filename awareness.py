import tkinter as tk
from tkinter import ttk
import os
import platform
import socket
import getpass
import random
import string
import time

# --- Forensic Data Gathering ---
def get_sys_info():
    try:
        user = getpass.getuser()
        host = socket.gethostname()
        ip = socket.gethostbyname(host)
        sys_os = f"{platform.system()} {platform.release()}"
        home_path = os.path.expanduser("~")
        all_files = []
        for root, dirs, files in os.walk(home_path):
            for name in files:
                if not name.startswith('.'):
                    all_files.append(os.path.join(root, name))
                if len(all_files) > 100: break
            if len(all_files) > 100: break
        return user, host, ip, sys_os, all_files
    except:
        return "root", "localhost", "127.0.0.1", "LINUX", ["/etc/passwd", "/home/user/wallet.dat", "/home/user/keys.asc"]

USER, HOST, IP, OS, FILES = get_sys_info()

def get_random_hash():
    return ''.join(random.choices(string.hexdigits.lower(), k=32))

class MalwareSimulation:
    def __init__(self, root):
        self.root = root
        self.lockout_duration = 60 # 1 minute in seconds
        self.start_time = time.time()
        self.can_exit = False
        
        # --- Extreme System-Level Hijack ---
        # Get actual screen dimensions for manual geometry
        screen_w = self.root.winfo_screenwidth()
        screen_h = self.root.winfo_screenheight()
        self.root.geometry(f"{screen_w}x{screen_h}+0+0")
        
        # Bypass Window Manager (removes taskbars, prevents workspace movement)
        self.root.overrideredirect(True)
        
        # Ensure the window is 'viewable' before grabbing focus
        self.root.update()
        
        # Ensure it's on top of everything
        self.root.attributes("-topmost", True)
        self.root.configure(bg="#050505", cursor="none")
        
        # Initial focus and input grab
        self.root.focus_force()
        self.root.grab_set()
        
        # Background Heartbeat: Periodically pull focus and stay on top
        self.maintain_dominance()
        
        self.style = ttk.Style()
        self.style.theme_use('default')
        self.style.configure("Hacker.Horizontal.TProgressbar", 
                             thickness=10, troughcolor='#111', background='#ff0033')

        # Header
        self.header = tk.Label(root, text="[ RE-INITIALIZING SYSTEM ]",
                              fg="#ff0033", bg="#050505", font=("Courier", 35, "bold"))
        self.header.pack(pady=(120, 20)) # Added padding for overrideredirect offset

        # Main Terminal Area
        self.terminal_frame = tk.Frame(root, bg="#050505")
        self.terminal_frame.pack(expand=True, fill="both", padx=80)
        
        self.terminal = tk.Text(self.terminal_frame, bg="#050505", fg="#00ff41", 
                                font=("Courier", 14), borderwidth=0, highlightthickness=0)
        self.terminal.pack(expand=True, fill="both")

        # Progress Section
        self.progress_frame = tk.Frame(root, bg="#050505")
        self.progress_label = tk.Label(self.progress_frame, text="LOCKING SYSTEM ARCHITECTURE...", 
                                      fg="#ff0033", bg="#050505", font=("Courier", 12, "bold"))
        self.progress_label.pack(side="top", anchor="w")
        
        self.progress = ttk.Progressbar(self.progress_frame, style="Hacker.Horizontal.TProgressbar", 
                                        length=800, mode='determinate')
        self.progress.pack(side="bottom", pady=(5, 50))

        # Bindings
        self.root.bind("<Escape>", self.attempt_exit)
        # Prevent common close shortcuts
        self.root.bind("<Alt-F4>", lambda e: "break")
        self.root.protocol("WM_DELETE_WINDOW", lambda: None)
        
        self.start_sequence()

    def log(self, text, color="#00ff41"):
        self.terminal.tag_config("color_" + color, foreground=color)
        self.terminal.insert("end", text + "\n", "color_" + color)
        self.terminal.see("end")

    def maintain_dominance(self):
        """Continuously re-assert system dominance to prevent workspace jumping."""
        self.root.focus_force()
        self.root.attributes("-topmost", True)
        self.root.lift()
        if not self.can_exit:
            self.root.after(500, self.maintain_dominance)
        else:
            self.root.configure(cursor="left_ptr") # Final reveal cursor restoration

    def attempt_exit(self, event=None):
        if self.can_exit:
            self.root.destroy()
        else:
            elapsed = int(time.time() - self.start_time)
            remaining = self.lockout_duration - elapsed
            if remaining > 0:
                self.log(f"\n[!] EXIT DENIED. KEYBOARD INTERCEPT ACTIVE. LOCKOUT: {remaining}s remaining.", "#ff0033")

    def start_sequence(self):
        self.root.after(1000, self.phase_recon)

    def phase_recon(self):
        self.header.config(text="[ VULNERABILITY EXPLOITED ]")
        self.log(f"[*] Payload successfully delivered to {USER}")
        self.log(f"[*] Establishing persistence on {HOST}")
        self.log(f"[*] Remote IP captured: {IP}")
        self.log("-" * 60)
        self.root.after(1500, self.phase_harvest)

    def phase_harvest(self):
        self.header.config(text="[ INDEXING SENSITIVE DATA ]")
        self.log("[!] ACCESSING PRIVATE STORAGE...", "#ffcc00")
        
        def list_files(idx=0):
            if idx < 30 and idx < len(FILES):
                self.log(f" TARGET: {FILES[idx]}")
                self.root.after(30, lambda: list_files(idx + 1))
            else:
                self.log(f"\n[+] Total assets indexed: {len(FILES)}", "#ffcc00")
                self.root.after(1000, self.phase_theft)
        list_files()

    def phase_theft(self):
        self.header.config(text="[ EXFILTRATING ASSETS ]", fg="#ff0033")
        self.progress_frame.pack(side="bottom", fill="x", padx=80)
        self.root.after(800, self.run_heist)

    def run_heist(self):
        current_val = 0
        def step():
            nonlocal current_val
            if current_val < 100:
                current_val += random.uniform(0.5, 4.0)
                if current_val > 100: current_val = 100
                self.progress['value'] = current_val
                
                # Rapid exfiltration logs
                file_idx = random.randint(0, len(FILES)-1)
                short_path = FILES[file_idx].split('/')[-1]
                self.log(f" [SENDING] {short_path[:20].ljust(20)} | BLOCK: {get_random_hash()[:10]} | OK")
                
                self.root.after(random.randint(10, 50), step)
            else:
                self.log("\n[+] SUCCESS: DATA STREAM SECURED BY REMOTE SERVER.", "#00ff41")
                self.root.after(2000, self.phase_reveal)
        step()

    def phase_reveal(self):
        for widget in self.root.winfo_children():
            widget.destroy()
            
        self.root.configure(bg="#0a0a0a", cursor="left_ptr") # Restore cursor
        
        self.title_lbl = tk.Label(self.root, text="[ SECURITY BREACH DETECTED ]",
                         fg="#ff0033", bg="#0a0a0a", font=("Courier", 40, "bold"))
        self.title_lbl.pack(pady=(60, 20))

        self.content_frame = tk.Frame(self.root, bg="#0a0a0a")
        self.content_frame.pack(expand=True)

        self.awareness_msg = """
SYSTEM COMPROMISE SIMULATION COMPLETE.
---------------------------------------------------

NO DATA WAS ACTUALLY STOLEN. YOU ARE SAFE.
This was a test of your 'COGNITIVE GAP'.

YOU ARE CURRENTLY IN A 'SECURITY LOCKDOWN' PHASE.
This is meant to simulate the feeling of having no 
control over your system after a breach.

In a real attack, your files would be encrypted 
and your access permanently revoked.

"The greatest exploit in the history of computing is 
not a line of code, but the exploitation of trust."
"""
        self.text_label = tk.Label(self.content_frame, text="",
                              fg="#ffffff", bg="#0a0a0a", font=("Courier", 18), 
                              justify="left")
        self.text_label.pack()

        self.timer_label = tk.Label(self.root, text="",
                                   fg="#ffcc00", bg="#0a0a0a", font=("Courier", 14, "bold"))
        self.timer_label.pack(side="bottom", pady=20)

        self.exit_hint = tk.Label(self.root, text="EXIT RESTRICTED UNTIL SECURITY BRIEFING IS COMPLETE",
                                 fg="#444444", bg="#0a0a0a", font=("Courier", 12))
        self.exit_hint.pack(side="bottom", pady=10)

        self.type_write()

    def type_write(self, idx=0):
        if idx < len(self.awareness_msg):
            self.text_label.config(text=self.awareness_msg[:idx+1] + "█")
            self.root.after(15, lambda: self.type_write(idx + 1))
        else:
            self.text_label.config(text=self.awareness_msg)
            self.start_timer_update()

    def start_timer_update(self):
        elapsed = int(time.time() - self.start_time)
        remaining = max(0, self.lockout_duration - elapsed)
        
        if remaining > 0:
            self.timer_label.config(text=f"MANDATORY SECURITY LOCKDOWN: {remaining}s REMAINING")
            self.root.after(1000, self.start_timer_update)
        else:
            self.can_exit = True
            self.title_lbl.config(text="[ AWARENESS COMPLETE ]", fg="#00ffcc")
            self.timer_label.config(text="SYSTEM SECURITY RESTORED", fg="#00ffcc")
            self.exit_hint.config(text="[ PRESS ESC TO ACKNOWLEDGE AND CONTACT RESEARCHER ]", fg="#ffffff")

if __name__ == "__main__":
    root = tk.Tk()
    app = MalwareSimulation(root)
    root.mainloop()
