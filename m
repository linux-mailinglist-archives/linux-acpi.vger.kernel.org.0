Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314421F88B4
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Jun 2020 14:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgFNMMg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 14 Jun 2020 08:12:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:39223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgFNMMf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 14 Jun 2020 08:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592136740;
        bh=Iqqad0ntz12j3v5mpaKUKYykQTjgNXFRgTPnHGw0OIk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=KWndPVevzZN05Ar9GkoBeIivz92/J2HWKOOixPBxUNbNx1DORT2+qFXs6QMlI8vEd
         Hc9N1uCLFXfVMZG2PEVP+TDbqLrkLRaXGnSP3Z5xkLl+2XvqgK1uz0wFUbtmlx3gRz
         Vk7/oaklKl7aNOeaOgzBJZCDN8clo2SXTfiURSgA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([188.109.161.30]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLiCu-1jSue40kpk-00HcFq; Sun, 14
 Jun 2020 14:12:20 +0200
From:   Stephen Berman <stephen.berman@gmx.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <87v9l65d2y.fsf@gmx.net>
        <20200513220428.4nksinis2qs5dtmh@linutronix.de>
        <87mu6aurfn.fsf@gmx.net>
        <20200522164012.ynyvrjompv42jtmx@linutronix.de>
        <87y2owwo2o.fsf@rub.de>
        <20200609202339.cgy57twm2zdtjhje@linutronix.de>
        <87tuzjcovq.fsf@gmx.net>
        <20200610102514.4vdzu5u7d6vnpicn@linutronix.de>
        <87imfyh6yx.fsf@gmx.net> <87wo4dligz.fsf@gmx.net>
        <20200612110122.jossn5zrktcvpbpm@linutronix.de>
Date:   Sun, 14 Jun 2020 14:12:18 +0200
In-Reply-To: <20200612110122.jossn5zrktcvpbpm@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Fri, 12 Jun 2020 13:01:22 +0200")
Message-ID: <87tuzdrgm5.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:YlIYtCyD4XIVpyJbh60ZMpkuY4afzHz3QrJ2Bv8pHjFFRIF8Dle
 ynJ4f4fMi9Eq5Rw0tMy8yPQxzNxVBPIWjqok401GuX4+5Jh/o+zZdpiz6wgLc6s//KV0JJf
 7ODH1cn+uwSFA0HOZQB7M3Ry5+H0mXPmm81g7/mr7fw2tPOBJuFoddrO9YVnpx3dPQB1fDC
 hIy5CvKGCMOlUOqezf+kA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Go46CsOEpaU=:cIjhhUD/Jgn0GJlz3Wz8TO
 IsHYvsgNdrwGh7IB9qgfwd5+krlHj1FOhij6Ayg7EfuR1KTZFaQm1ogYFjqkZ1ywG3vX1172j
 snKiDPBL5uQFYJJdnJgN3a7hn8RRoX8wYfBVrnmLPCBVvGcT6VCHi/MyALeTbkX0cTSbgH6BI
 yRbhuY+cqUf/0J3CE/whZnkfzPt/FdI/im/Usz6SASBtV20/RddKy4Uzji6Gi9WEsLf9RpEuy
 ENgtWHBQ5OleG7CIWXx6NpUJC/7n/eeuoLHRdwxEbBj8PuQK9+iHnjRSJXrIpx3IDFlIkFend
 /bdKip9BwmMvW6wFhxVKnCuBlHXqraAlkAfH+C4RNPIC2Te9hx4tFZKqU5fJT4YL5yeCsyCfX
 k03+JII1kVQnKGKJFLckcSgTJZkxgCeRL7bLqVgZoMMkiMWjT7whOx5+CR55/dARHyhSQpUSq
 y+5J8oxFP0gMq77RLpDvg5JCYzMS6PIaiyYs22J/GHXXoDBOa2+lSRaYVtFP1zmEgTF3urcN7
 i14tpRk65sOJuiHe2Ndr5tojhhU28Oiknkeequ8bmtZjJ0AVLRIXwpPo81Kd0wfuNVbUleeuh
 khECQejKC2NbsoBTq8I9va7wm3O8FZKNRWBRHooVIXfXKOJELoe7VAmxuf+elQQfDbcuJSD27
 CyPCPt4AKHgQpZAZ385BhPdHgOW4bTf9bxMnQtsZNZxUIHAzeRnqO9vkJBIrt7X0ODhtCRTjZ
 yIp0D3Ga40SlW8LM2KB5bWMdmFT2jRf/LtiQEYwb9r6X1rs/YucLjJSWu4sfdV7JuzmfLcfBP
 P8RfYRBkHcO9vWkSd/VVZ6L+E70sWzVZQrxYWw4MQDSc0Wcm8D8M2e3jWtLFN8tvUcTOeePLx
 H2jhAz2m1bFAEFduTu/+Mk/XmbFXvkXMsRgK/FW0a/nmurLxcETbNSixPoEnrWG/qy6j0bJgw
 bnBY9MfktnBr3GvTy0smZPcsY4ROF9+d9X+ayinReTQ85X4H3xljJIBxmRwysnOYHsCTMLUJ4
 SQKFsK995MIr/ClAqjehFriUePHY20qu9juGcRsuy6htiNc+HD+6mmdCbd3DMaDd6tDLNl/Vs
 ck2h5ODV10BapCN81Ej3R57w8MVwEXkDKd/znnpMM1wtHkPWyH9NJdlsldrUPfFx83C54KbwR
 DCj4Cedmpz32DgyybFLoCAag0Zi+jDA49BkIvQxgCw6r0m550RcOOLj1yTJzSLw59dsnqFd6i
 9rwC4bsetjQ9xNGPt
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 12 Jun 2020 13:01:22 +0200 Sebastian Andrzej Siewior <bigeasy@linu=
tronix.de> wrote:

> + ACPI in case the ACPI folks see something obvious.
[...]
>> The "acpi_os_execute_deferred" messages were repeated many times in the
>> above line, then every 20-30 seconds again for several minutes.  Then
>> suddenly a call trace appeared which was similar but not identical to
>> the one I posted upthread, and each line of the trace was followed by
>> the line ", acpi_os_execute_deferred".  This went by quite quickly even
>> with the printk_delay I added, and I was unable to photograph the start
>> of it and couldn't get all of the subsequent output, but the screenshot=
s
>> show some of it.  After several minutes of this output I again did a
>> hard reboot.
>
> All good. I though that you will have one worker that is blocking but
> you have a lot of them. It appears that one is active and stuck and more
> are waiting.
>
> Could you look at acpi in /proc/interrupts 10 secs apart to see if it
> increments?
>
>    grep -E 'acpi|smbus' /proc/interrupts

I tried this several times, 10 seconds apart and longer, but saw no
change, it was always this:

steve [ ~ ]$ grep -E 'acpi|smbus' /proc/interrupts
   9:          0          5          0          0          0          0   =
       0          0          0          0          0          0   IO-APIC =
   9-fasteoi   acpi
  16:          0          0          0          0          0          0   =
       0          0          0          0          0          0   IO-APIC =
  16-fasteoi   i801_smbus

> You could also do "echo t > /proc/sysrq-trigger" which gives you a lot
> of task state information, but at the end you will also see "howing busy
> workqueues and worker pools:" regarding the workqueue state. I am
> curious to see if you already have worker stuck in kacpid_notify with
> acpi_os_execute_deferred.

What am I supposed to do after "echo t > /proc/sysrq-trigger"?  Both
before and after doing that I get an error trying to open the file:

root [ ~ ]# cat /proc/sysrq-trigger
cat: /proc/sysrq-trigger: Input/output error

> Now that we know that know that acpi_os_execute_deferred() is stuck,
> lets shed some light in what it is trying to do. The patch at the end
> will dump this information into the console buffer (The `dmesg' command
> will print the whole kernel buffer). I have no idea if this starts
> printing while the system is running or during shutdown.  I would expect
> to see the Start line in acpi_os_execute_deferred() but not the End one.
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 41168c027a5a4..0e983c558bcb5 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -840,7 +840,9 @@ static void acpi_os_execute_deferred(struct work_str=
uct *work)
>  {
>  	struct acpi_os_dpc *dpc =3D container_of(work, struct acpi_os_dpc, wor=
k);
>
> +	pr_err("%s(%d) Start %px %pF(%px)\n", __func__, __LINE__, dpc, dpc->fu=
nction, dpc->context);
>  	dpc->function(dpc->context);
> +	pr_err("%s(%d) End   %px %pF(%px)\n", __func__, __LINE__, dpc, dpc->fu=
nction, dpc->context);
>  	kfree(dpc);
>  }
>
> @@ -1096,6 +1098,8 @@ acpi_status acpi_os_execute(acpi_execute_type type=
,
>  	 */
>  	if (type =3D=3D OSL_NOTIFY_HANDLER) {
>  		queue =3D kacpi_notify_wq;
> +		pr_err("%s(%d) Adding %pS %px\n", __func__, __LINE__, function,
> +		       context);
>  		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
>  	} else if (type =3D=3D OSL_GPE_HANDLER) {
>  		queue =3D kacpid_wq;

I applied this patch to 5.6.4 and recompiled, and on the next boot with
that kernel, the kernel buffer (and kernel and system logs) began to get
flooded with these messages:

Jun 14 10:37:13 strobe-jhalfs kernel: [    5.943987] acpi_os_execute_defer=
red(843) Start ffff8fb82c7b6500 000000003edf1e05(ffff8fb82c492990)
Jun 14 10:37:13 strobe-jhalfs kernel: [    5.944102] acpi_os_execute(1101)=
 Adding acpi_ev_asynch_enable_gpe+0x0/0x2f ffff8fb82c492990
Jun 14 10:37:13 strobe-jhalfs kernel: [    5.944104] acpi_os_execute_defer=
red(845) End   ffff8fb82c7b6500 000000003edf1e05(ffff8fb82c492990)
Jun 14 10:37:13 strobe-jhalfs kernel: [    5.944105] acpi_os_execute_defer=
red(843) Start ffff8fb82b844800 000000002ba560ea(ffff8fb82c492990)
Jun 14 10:37:13 strobe-jhalfs kernel: [    5.944124] acpi_os_execute_defer=
red(845) End   ffff8fb82b844800 000000002ba560ea(ffff8fb82c492990)
Jun 14 10:37:13 strobe-jhalfs kernel: [    5.944288] acpi_os_execute_defer=
red(843) Start ffff8fb82c7b6540 000000003edf1e05(ffff8fb82c492990)
Jun 14 10:37:13 strobe-jhalfs kernel: [    5.944387] acpi_os_execute(1101)=
 Adding acpi_ev_asynch_enable_gpe+0x0/0x2f ffff8fb82c492990

and so on without stopping.  I could start X and avoid seeing the
messages, but was afraid the logs would fill up the root partition if I
let it keep going, so I rebooted with another kernel.

Was this message flood because I booted with "ignore_loglevel
initcall_debug"?  In the logs there are also lots of messages like this:

Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237628] initcall i915_init+0x=
0/0x66 returned 0 after 288657 usecs
Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237644] calling  cn_proc_init=
+0x0/0x35 @ 1
Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237646] initcall cn_proc_init=
+0x0/0x35 returned 0 after 0 usecs
Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237648] calling  _nvm_misc_in=
it+0x0/0xc @ 1
Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237687] initcall _nvm_misc_in=
it+0x0/0xc returned 0 after 36 usecs
Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237690] calling  topology_sys=
fs_init+0x0/0x30 @ 1
Jun 14 10:37:13 strobe-jhalfs kernel: [    6.237720] initcall topology_sys=
fs_init+0x0/0x30 returned 0 after 28 usecs

and so on.

Steve Berman
