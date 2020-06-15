Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4520D1F9ADB
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jun 2020 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgFOOvd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jun 2020 10:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgFOOvd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2020 10:51:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96C8C061A0E;
        Mon, 15 Jun 2020 07:51:32 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jkqSQ-0004kV-7n; Mon, 15 Jun 2020 16:51:30 +0200
Date:   Mon, 15 Jun 2020 16:51:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
References: <87y2owwo2o.fsf@rub.de>
 <20200609202339.cgy57twm2zdtjhje@linutronix.de>
 <87tuzjcovq.fsf@gmx.net>
 <20200610102514.4vdzu5u7d6vnpicn@linutronix.de>
 <87imfyh6yx.fsf@gmx.net>
 <87wo4dligz.fsf@gmx.net>
 <20200612110122.jossn5zrktcvpbpm@linutronix.de>
 <87tuzdrgm5.fsf@gmx.net>
 <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
 <874krcsquv.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oidbd7fmhy4rt4hc"
Content-Disposition: inline
In-Reply-To: <874krcsquv.fsf@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--oidbd7fmhy4rt4hc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-15 09:58:00 [+0200], Stephen Berman wrote:
> Ok, sorry, I had misunderstood, but now I've looked at the
> documentation.  I had in fact already done `echo t >
> /proc/sysrq-trigger' in an xterm (as root) and there was no output.
> Later, after booting kernel 5.1.0 because of the message flooding with
> 5.6.4, I did `echo t > /proc/sysrq-trigger' in a virtual tty (also as
> root) and the only output was: `[ <timestamp>] sysrq: Show State'.  Is
> this expected?  (In /proc/sys/kernel/sysrq there is `1'.)  I couldn't
> try it in a 5.6.4 virtual tty because of the message flooding (see
> below).

If you do this "t" then there should be a lot of output on your console.
If you do this from an xterm then you can see the output after typing
"dmesg". The output should appear also in your system log.

> The kernel log shows 305 of these messages in the 4 minutes and 17
> seconds between the start of klogd and when I rebooted.

Okay, this is a lot.

> > The interesting part is to see if there is a acpi_os_execute() adding a
> > specific event multiple times which does not complete. Maybe at runtime,
> > maybe at shutdown time. If that is the case then ignoring this specific
> > event might fix the shutdown problem. With all this information so far,
> > I don't see a relation with this problem and the commit=E2=80=A6
>=20
> In those 3 minutes and 8 seconds there were 5 "Adding
> acpi_ev_asynch_enable_gpe" messages at the beginning, then 185 "Adding
> acpi_ev_notify_dispatch" messages, which kept coming until I rebooted.

5 acpi_ev_asynch_enable_gpe() in three minutes since boot isn't much.
185 of "Adding acpi_ev_notify_dispatch" is a lot.

But to be clear, only=20
  acpi_os_execute(1109) Adding acpi_ev_notify_dispatch" messages?
No
  "acpi_os_execute_deferred_notify() Start/End acpi_ev_notify_dispatch"?=20

The syslog should have captured the log on disk.

I attached a modified acpi_dbg.patch. Please enable:
- CONFIG_ACPI_DEBUG=3Dy

Looking at your 5.1 you have tracing enabled (hope it still is).

The attached patch will dump the date into the tracing buffer, so you
console should remain "clean". Once it records 300 of those "requests
for acpi_ev_notify_dispatch" it will stop recording.
After 4-5 minutes please do
	cat /sys/kernel/debug/tracing/trace > file.txt

compress it and send it.

> Steve Berman

Sebastian

--oidbd7fmhy4rt4hc
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="acpi_dbg.patch"

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 3e39907fedd9..816e23d103c6 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -477,6 +477,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 		 * notifies on multiple device objects.
 		 */
 		notify = gpe_event_info->dispatch.notify_list;
+		trace_printk("notify %px\n", gpe_event_info);
 		while (ACPI_SUCCESS(status) && notify) {
 			status =
 			    acpi_ev_queue_notify_request(notify->device_node,
@@ -484,6 +485,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 
 			notify = notify->next;
 		}
+		trace_printk("Event notify %px done %x\n", gpe_event_info, status);
 
 		break;
 
@@ -491,6 +493,9 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 
 		/* Allocate the evaluation information block */
 
+		trace_printk("Evaluate %4.4s\n",
+			     acpi_ut_get_node_name(gpe_event_info->dispatch.method_node));
+
 		info = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_evaluate_info));
 		if (!info) {
 			status = AE_NO_MEMORY;
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index ce1eda6beb84..735057419a8e 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -72,6 +72,7 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node *node, u32 notify_value)
 	union acpi_generic_state *info;
 	u8 handler_list_id = 0;
 	acpi_status status = AE_OK;
+	static int num_req = 0;
 
 	ACPI_FUNCTION_NAME(ev_queue_notify_request);
 
@@ -129,19 +130,19 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node *node, u32 notify_value)
 	info->notify.handler_list_head = handler_list_head;
 	info->notify.global = &acpi_gbl_global_notify[handler_list_id];
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Dispatching Notify on [%4.4s] (%s) Value 0x%2.2X (%s) Node %p\n",
+	trace_printk("Dispatching Notify on [%4.4s] (%s) Value 0x%2.2X (%s) Node %px\n",
 			  acpi_ut_get_node_name(node),
 			  acpi_ut_get_type_name(node->type), notify_value,
 			  acpi_ut_get_notify_name(notify_value, ACPI_TYPE_ANY),
-			  node));
+			  node);
 
 	status = acpi_os_execute(OSL_NOTIFY_HANDLER,
 				 acpi_ev_notify_dispatch, info);
 	if (ACPI_FAILURE(status)) {
 		acpi_ut_delete_generic_state(info);
 	}
-
+	if (num_req++ == 300)
+		tracing_off();
 	return (status);
 }
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 762c5d50b8fe..67d5ac9aa433 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -844,6 +844,16 @@ static void acpi_os_execute_deferred(struct work_struct *work)
 	kfree(dpc);
 }
 
+static void acpi_os_execute_deferred_notify(struct work_struct *work)
+{
+	struct acpi_os_dpc *dpc = container_of(work, struct acpi_os_dpc, work);
+
+	trace_printk("Start %px %pS(%px)\n", dpc, dpc->function, dpc->context);
+	dpc->function(dpc->context);
+	trace_printk("End %px %pS(%px)\n", dpc, dpc->function, dpc->context);
+	kfree(dpc);
+}
+
 #ifdef CONFIG_ACPI_DEBUGGER
 static struct acpi_debugger acpi_debugger;
 static bool acpi_debugger_initialized;
@@ -1096,7 +1106,8 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	 */
 	if (type == OSL_NOTIFY_HANDLER) {
 		queue = kacpi_notify_wq;
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+		trace_printk("Adding %pS %px <%px>\n", function, context, dpc);
+		INIT_WORK(&dpc->work, acpi_os_execute_deferred_notify);
 	} else if (type == OSL_GPE_HANDLER) {
 		queue = kacpid_wq;
 		INIT_WORK(&dpc->work, acpi_os_execute_deferred);

--oidbd7fmhy4rt4hc--
