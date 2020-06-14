Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286251F89C8
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Jun 2020 19:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgFNRKK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 14 Jun 2020 13:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgFNRKK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Jun 2020 13:10:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7B1C05BD43;
        Sun, 14 Jun 2020 10:10:10 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jkW8z-00031s-5Z; Sun, 14 Jun 2020 19:10:05 +0200
Date:   Sun, 14 Jun 2020 19:10:05 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
References: <87mu6aurfn.fsf@gmx.net>
 <20200522164012.ynyvrjompv42jtmx@linutronix.de>
 <87y2owwo2o.fsf@rub.de>
 <20200609202339.cgy57twm2zdtjhje@linutronix.de>
 <87tuzjcovq.fsf@gmx.net>
 <20200610102514.4vdzu5u7d6vnpicn@linutronix.de>
 <87imfyh6yx.fsf@gmx.net>
 <87wo4dligz.fsf@gmx.net>
 <20200612110122.jossn5zrktcvpbpm@linutronix.de>
 <87tuzdrgm5.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jrrgi5ttcponjov2"
Content-Disposition: inline
In-Reply-To: <87tuzdrgm5.fsf@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--jrrgi5ttcponjov2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-14 14:12:18 [+0200], Stephen Berman wrote:
> On Fri, 12 Jun 2020 13:01:22 +0200 Sebastian Andrzej Siewior <bigeasy@lin=
utronix.de> wrote:
>=20
> steve [ ~ ]$ grep -E 'acpi|smbus' /proc/interrupts
>    9:          0          5          0          0          0          0  =
        0          0          0          0          0          0   IO-APIC =
   9-fasteoi   acpi
>   16:          0          0          0          0          0          0  =
        0          0          0          0          0          0   IO-APIC =
  16-fasteoi   i801_smbus

okay, so it is not increasing at runtime.

> > You could also do "echo t > /proc/sysrq-trigger" which gives you a lot
> > of task state information, but at the end you will also see "howing busy
> > workqueues and worker pools:" regarding the workqueue state. I am
> > curious to see if you already have worker stuck in kacpid_notify with
> > acpi_os_execute_deferred.
>=20
> What am I supposed to do after "echo t > /proc/sysrq-trigger"?  Both
> before and after doing that I get an error trying to open the file:
>=20
> root [ ~ ]# cat /proc/sysrq-trigger
> cat: /proc/sysrq-trigger: Input/output error

 echo "t > /proc/sysrq-trigger"

not cat.

> > Now that we know that know that acpi_os_execute_deferred() is stuck,
> > lets shed some light in what it is trying to do. The patch at the end
> > will dump this information into the console buffer (The `dmesg' command
> > will print the whole kernel buffer). I have no idea if this starts
> > printing while the system is running or during shutdown.  I would expect
> > to see the Start line in acpi_os_execute_deferred() but not the End one.
> >
> > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > index 41168c027a5a4..0e983c558bcb5 100644
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -840,7 +840,9 @@ static void acpi_os_execute_deferred(struct work_st=
ruct *work)
> >  {
> >  	struct acpi_os_dpc *dpc =3D container_of(work, struct acpi_os_dpc, wo=
rk);
> >
> > +	pr_err("%s(%d) Start %px %pF(%px)\n", __func__, __LINE__, dpc, dpc->f=
unction, dpc->context);
> >  	dpc->function(dpc->context);
> > +	pr_err("%s(%d) End   %px %pF(%px)\n", __func__, __LINE__, dpc, dpc->f=
unction, dpc->context);
> >  	kfree(dpc);
> >  }

argh, this should have been %pS not %pF. Sorry for that.

> > @@ -1096,6 +1098,8 @@ acpi_status acpi_os_execute(acpi_execute_type typ=
e,
> >  	 */
> >  	if (type =3D=3D OSL_NOTIFY_HANDLER) {
> >  		queue =3D kacpi_notify_wq;
> > +		pr_err("%s(%d) Adding %pS %px\n", __func__, __LINE__, function,
> > +		       context);
> >  		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
> >  	} else if (type =3D=3D OSL_GPE_HANDLER) {
> >  		queue =3D kacpid_wq;
>=20
> I applied this patch to 5.6.4 and recompiled, and on the next boot with
> that kernel, the kernel buffer (and kernel and system logs) began to get
> flooded with these messages:
>=20
> Jun 14 10:37:13 strobe-jhalfs kernel: [    5.943987] acpi_os_execute_defe=
rred(843) Start ffff8fb82c7b6500 000000003edf1e05(ffff8fb82c492990)
> Jun 14 10:37:13 strobe-jhalfs kernel: [    5.944102] acpi_os_execute(1101=
) Adding acpi_ev_asynch_enable_gpe+0x0/0x2f ffff8fb82c492990
> Jun 14 10:37:13 strobe-jhalfs kernel: [    5.944104] acpi_os_execute_defe=
rred(845) End   ffff8fb82c7b6500 000000003edf1e05(ffff8fb82c492990)
> Jun 14 10:37:13 strobe-jhalfs kernel: [    5.944105] acpi_os_execute_defe=
rred(843) Start ffff8fb82b844800 000000002ba560ea(ffff8fb82c492990)
> Jun 14 10:37:13 strobe-jhalfs kernel: [    5.944124] acpi_os_execute_defe=
rred(845) End   ffff8fb82b844800 000000002ba560ea(ffff8fb82c492990)
> Jun 14 10:37:13 strobe-jhalfs kernel: [    5.944288] acpi_os_execute_defe=
rred(843) Start ffff8fb82c7b6540 000000003edf1e05(ffff8fb82c492990)
> Jun 14 10:37:13 strobe-jhalfs kernel: [    5.944387] acpi_os_execute(1101=
) Adding acpi_ev_asynch_enable_gpe+0x0/0x2f ffff8fb82c492990
>=20
> and so on without stopping.  I could start X and avoid seeing the
> messages, but was afraid the logs would fill up the root partition if I
> let it keep going, so I rebooted with another kernel.
>=20
> Was this message flood because I booted with "ignore_loglevel
> initcall_debug"?  In the logs there are also lots of messages like this:

Is there a acpi_os_execute_* flood? The *few* at what appears to system
startup and might be normal. If there appear *many* more and are
constantly printing (check with dmesg) then we might be to something.

> Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237628] initcall i915_init+0=
x0/0x66 returned 0 after 288657 usecs
> Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237644] calling  cn_proc_ini=
t+0x0/0x35 @ 1
> Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237646] initcall cn_proc_ini=
t+0x0/0x35 returned 0 after 0 usecs
> Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237648] calling  _nvm_misc_i=
nit+0x0/0xc @ 1
> Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237687] initcall _nvm_misc_i=
nit+0x0/0xc returned 0 after 36 usecs
> Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237690] calling  topology_sy=
sfs_init+0x0/0x30 @ 1
> Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237720] initcall topology_sy=
sfs_init+0x0/0x30 returned 0 after 28 usecs
>
> and so on.

You have initcalls here which is due to "initcall_debug". The i915*
message means that the i915 module was loaded.

That "initcall_debug" prints you starts/stops of modules that are loaded
(built-in or loaded modules) and shutdown callbacks which are invoked at
system shutdown. The "ignore_loglevel" shows prints all messages to the
console ignoring the current loglevel. Otherwise it would skip messages
with a "minor" loglevel. With this we were able to see the shutdown
callbacks (of the ahci module for instance).

I attached the updated acpi patch. It limits the prints to the
kacpi_notify_wq queue which appears to stuck at shutdown.

The interesting part is to see if there is a acpi_os_execute() adding a
specific event multiple times which does not complete. Maybe at runtime,
maybe at shutdown time. If that is the case then ignoring this specific
event might fix the shutdown problem. With all this information so far,
I don't see a relation with this problem and the commit=E2=80=A6

> Steve Berman

Sebastian

--jrrgi5ttcponjov2
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="acpi_dbg.patch"

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 762c5d50b8fe..a08789fb330e 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -844,6 +844,16 @@ static void acpi_os_execute_deferred(struct work_struct *work)
 	kfree(dpc);
 }
 
+static void acpi_os_execute_deferred_notify(struct work_struct *work)
+{
+	struct acpi_os_dpc *dpc = container_of(work, struct acpi_os_dpc, work);
+
+	pr_err("%s(%d) Start %px %pS(%px)\n", __func__, __LINE__, dpc, dpc->function, dpc->context);
+	dpc->function(dpc->context);
+	pr_err("%s(%d) End   %px %pS(%px)\n", __func__, __LINE__, dpc, dpc->function, dpc->context);
+	kfree(dpc);
+}
+
 #ifdef CONFIG_ACPI_DEBUGGER
 static struct acpi_debugger acpi_debugger;
 static bool acpi_debugger_initialized;
@@ -1096,7 +1106,9 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	 */
 	if (type == OSL_NOTIFY_HANDLER) {
 		queue = kacpi_notify_wq;
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+		pr_err("%s(%d) Adding %pS %px <%px>\n", __func__, __LINE__, function,
+		       context, dpc);
+		INIT_WORK(&dpc->work, acpi_os_execute_deferred_notify);
 	} else if (type == OSL_GPE_HANDLER) {
 		queue = kacpid_wq;
 		INIT_WORK(&dpc->work, acpi_os_execute_deferred);

--jrrgi5ttcponjov2
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="acpi_dbg.patch"

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 762c5d50b8fe..a08789fb330e 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -844,6 +844,16 @@ static void acpi_os_execute_deferred(struct work_struct *work)
 	kfree(dpc);
 }
 
+static void acpi_os_execute_deferred_notify(struct work_struct *work)
+{
+	struct acpi_os_dpc *dpc = container_of(work, struct acpi_os_dpc, work);
+
+	pr_err("%s(%d) Start %px %pS(%px)\n", __func__, __LINE__, dpc, dpc->function, dpc->context);
+	dpc->function(dpc->context);
+	pr_err("%s(%d) End   %px %pS(%px)\n", __func__, __LINE__, dpc, dpc->function, dpc->context);
+	kfree(dpc);
+}
+
 #ifdef CONFIG_ACPI_DEBUGGER
 static struct acpi_debugger acpi_debugger;
 static bool acpi_debugger_initialized;
@@ -1096,7 +1106,9 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	 */
 	if (type == OSL_NOTIFY_HANDLER) {
 		queue = kacpi_notify_wq;
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+		pr_err("%s(%d) Adding %pS %px <%px>\n", __func__, __LINE__, function,
+		       context, dpc);
+		INIT_WORK(&dpc->work, acpi_os_execute_deferred_notify);
 	} else if (type == OSL_GPE_HANDLER) {
 		queue = kacpid_wq;
 		INIT_WORK(&dpc->work, acpi_os_execute_deferred);

--jrrgi5ttcponjov2--
