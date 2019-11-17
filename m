Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D761BFFAA6
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2019 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfKQQNU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Nov 2019 11:13:20 -0500
Received: from cmta19.telus.net ([209.171.16.92]:45515 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfKQQNU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 17 Nov 2019 11:13:20 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id WNApi85OLhFQMWNAqijTzR; Sun, 17 Nov 2019 09:13:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1574007198; bh=/83FfEBDfmvBw04Q4UuVZoxQgu1KAV2tcdoKts6VNow=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=H6tt7LXs3vrKYjyHpu0ZwWsQqbDJ2mZAsPyvA1QEIOOKOpRs2S8cdj3pnSyFeJzzy
         kerZ2ZLXPlU+3fRpQ1UTA5eAU6f6KW+e8Vk1PgG7Na/gQpBTUGbvGU+0eFDqNKjvid
         NKKED9MVFkrhfECmF0FiU5gtARz4aw/02ZD0Rels1lXZZpykE8QstDWKumMFnPEnGC
         IzoJWy3ZZeQffjz5i1ZZagIJ50jlHp+hcEQYWbNNQoPsY+/zrWqmBVJ0aU+gaZuqcw
         VbzQ3pSSJFzb7VtT28wTP7SrPwDymLtZHwiNhAN85fxXcOpcMX4iqnLp0gkYmu2oFl
         wGRfgTLx3g5vA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=ZPWpZkzb c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8 a=pk_skBFnF1ww1f-5cLQA:9 a=CjuIK1q_8ugA:10
 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
Cc:     "'Linux ACPI'" <linux-acpi@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Sudeep Holla'" <sudeep.holla@arm.com>,
        "'Dmitry Osipenko'" <digetx@gmail.com>
References: <2811202.iOFZ6YHztY@kreacher> <4551555.oysnf1Sd0E@kreacher> 
In-Reply-To: 
Subject: RE: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
Date:   Sun, 17 Nov 2019 08:13:13 -0800
Message-ID: <000001d59d61$eb4e6670$c1eb3350$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdWED0vlByLFQ8J4Rz2jUgcX377w8gZBYsHgABMAilA=
X-CMAE-Envelope: MS4wfF/JGJ1eYjQlKjqKAe7kaaAk7UWmlqKC95adLwFboHlEdj7PHS/9oAHE45UqhqPtIXG3Fc54CD2dNHhLK1dUe4vw7P1Ktg5Ej4Pe5QGBHX/lxoh7SivR
 dqb40cloNjo8AMaFPrU/HLIZ7X5vtt06Ss71oGVvt9jW+lAhRkUEjYtAD6Re4TvTP60tCpRQs68lYqL65SeE8CVx9O24hya8oeCljFt5CkeXQlSK/BOSZRI+
 +CBT9jpq2qWQakOmi26Xr+h6aNomPefKY6n72qjMQ/daGG/Gk7SkxgCt0ixPBDcvN1LtBASHd0DFqPELMSSIV81SLuQB3/M7w/sprzQEXfm3tTUTGojnY1l0
 hlCdbJWtvOOOV3E8EAPCgpWnZHGG8A==
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Apologies if people are getting this e-mail twice.
Because it had an attachment, I think it got deleted
from list distribution.

On 2019.11.16 23:35 Doug Smythies wrote:
> On 2019.10.16 03:41 Rafael J. Wysocki wrote:
>
> ... deleted ...
>
> Hi Rafael,
>
> Not sure, but I think it is this one that
> causes complaining when I try to set the
> intel_pstate driver to passive mode.
> I started from active mode, powersave governor,
> no HWP.
>
> Kernel: 5.4-rc7
>
> I did not go back and try previous 5.4 RCs.
> I did try kernel 5.3-rc8, because I already had
> it installed, and it worked fine.
>
> I use a script (for years), run as sudo:
>
> doug@s15:~/temp$ cat set_cpu_passive
> #! /bin/bash
> cat /sys/devices/system/cpu/intel_pstate/status
> echo passive > /sys/devices/system/cpu/intel_pstate/status
> cat /sys/devices/system/cpu/intel_pstate/status
>
> And I get this (very small excerpt):
>
> freq_qos_add_request() called for active request
> WARNING: CPU: 1 PID: 2758 at kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0
> CPU: 1 PID: 2758 Comm: set_cpu_passive Not tainted 5.4.0-rc7-stock #727
> Failed to add freq constraint for CPU0 (-22)
>
> freq_qos_add_request() called for active request
> WARNING: CPU: 1 PID: 2758 at kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0
> CPU: 1 PID: 2758 Comm: set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727
> Failed to add freq constraint for CPU1 (-22)
>
> ...
>
> I'll attach the whole thing, but it will likely get removed
> from the general list e-mails.
>
> ... Doug

I forgot to mention, other than the error messages,
things seems to work fine.

If anyone wants to see what was the attachment, it
is here (for a few days):

http://www.smythies.com/~doug/temp_kernel/rjw.txt


