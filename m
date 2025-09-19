Return-Path: <linux-acpi+bounces-17142-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E05B8A862
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 18:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0EA7E6F35
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB13031FEF6;
	Fri, 19 Sep 2025 16:12:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4691D31E890;
	Fri, 19 Sep 2025 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298320; cv=none; b=f5KJqraVEjZffCvC7o7s2p1EOyWNtUMLcr9Y3Zy1U+MyNzLwNxgm9G5h1gcf5iJnmjK/0s+zS5RnChkABDMULaUMXwGCX4ionWZSczHRFGPYFKulbCkyzjqSllXOvL7It+vNTVdIuZnXPenZjZ9/6YKszGxITjoMeqB2aRej3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298320; c=relaxed/simple;
	bh=0bGLcSO1TyYzhtkJlye5XFzHCiHkXKUcNqKJa1tmWpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bl5s/pSdsDUqjJZPL2P13q2vmdeC4phrsCibwFvmi6aEJUqI8ywxDO0RvRfjrNMSuv8wKKA3ozD4y+kP1p6xpz97QR+Y+IbXtTY9nzmvYVfph3nIqYZSlthQAV1aJVY86jjIMtYXGrwEMD85SQNETV6Vd1MKWEVTEpeQYqaScR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81E661BA8;
	Fri, 19 Sep 2025 09:11:50 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D0F73F66E;
	Fri, 19 Sep 2025 09:11:52 -0700 (PDT)
Message-ID: <e403809c-195f-48ca-a8f1-9eb785f229e9@arm.com>
Date: Fri, 19 Sep 2025 17:11:51 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm_mpam: Try reading again if MPAM instance returns not
 ready
To: Zeng Heng <zengheng4@huawei.com>
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jonathan.cameron@huawei.com, kobak@nvidia.com, lcherian@marvell.com,
 lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20250910204309.20751-7-james.morse@arm.com>
 <20250916131717.2980875-1-zengheng4@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250916131717.2980875-1-zengheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Zeng,

On 16/09/2025 14:17, Zeng Heng wrote:
> After updating the monitor configuration, the first read of the monitoring
> result requires waiting for the "not ready" duration before an effective
> value can be obtained.

May need to wait - some platforms need to do this, some don't.
Yours is the first I've heard of that does this!


> Because a component consists of multiple MPAM instances, after updating the
> configuration of each instance, should wait for the "not ready" period of
> per single instance before the valid monitoring value can be obtained, not
> just wait for once interval per component.

I'm really trying to avoid that ... if you have ~200 MSC pretending to be one thing, you'd
wait 200x the maximum period. On systems with CMN, the number of MSC scales with the
number of CPUs, so 200x isn't totally crazy.

I think the real problem here is the driver doesn't go on to reconfigure MSC-2 if MSC-1
returned not-ready, meaning the "I'll only wait once" logic kicks in and returns not-ready
to the user. (which is presumably what you're seeing?)

Does this solve your problem?:
-----------------%<-----------------
diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 404bd4c1fd5e..2f39d0339349 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1395,7 +1395,7 @@ static void __ris_msmon_read(void *arg)

 static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
 {
-       int err, idx;
+       int err, any_err = 0, idx;
        struct mpam_msc *msc;
        struct mpam_vmsc *vmsc;
        struct mpam_msc_ris *ris;
@@ -1412,15 +1412,19 @@ static int _msmon_read(struct mpam_component *comp, stru
ct mon_read *arg)
                                                    true);
                        if (!err && arg->err)
                                err = arg->err;
+
+                       /*
+                        * Save one error to be returned to the caller, but
+                        * keep reading counters so that the get reprogrammed.
+                        * On platforms with NRDY this lets us wait once.
+                        */
                        if (err)
-                               break;
+                               any_err = err;
                }
-               if (err)
-                       break;
        }
        srcu_read_unlock(&mpam_srcu, idx);

-       return err;
+       return any_err;
 }

 int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
-----------------%<-----------------


Thanks,

James

