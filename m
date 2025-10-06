Return-Path: <linux-acpi+bounces-17636-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD35BBFCA1
	for <lists+linux-acpi@lfdr.de>; Tue, 07 Oct 2025 01:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1D444E559C
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 23:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C05D20296E;
	Mon,  6 Oct 2025 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+D/gyMg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A41FAC4B
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759794149; cv=none; b=ATAARu0NwQK4j2mo05Ds9/YoYrmyY96ErUvdAnEWJYqjCRX2RqC2GelNLm74KyQfDFKtPoPIOU5jD9v/IZk27Bhp4QzqmnzTBNDgGFz8BHyx9E2c5M44bzUTu6hFSFi7uiRkJSaC2h1a4zlljP6AC5YaBUS30pzkVuD9Au9CYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759794149; c=relaxed/simple;
	bh=I1LRnW+vY63k1Mx1je5Uo5vhO6U35Vc+kskyhau2eCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJuE6RBArcFmU+l90Chd7iwGl9jdPOl6vYCagNPmf/Emz79xPrJJ5S2irdgSk5vhqiqjwkpnwWak64aDSp4lAQI6OTEIvYEyl2uL+19P5obKjcmzMTr3Qk8sUd44o0jFi3kgrfHpAug0EQ+L80yIZXPR97SjleS9V3CuJmYlQyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+D/gyMg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759794146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCfiz5Ut6f0Hmx5GZ2r8SOtef3xDzej4Rj97vBZKv8A=;
	b=Y+D/gyMg8fW2eCqdli5wXlocEvfQf5POOHAfGAUb3mcMIsdICfomcz6MQNV/qKUQx52JQV
	x8SngdZOVHxdbyL7jEiHIDiAq9K0l2tnWjlrSc2XbXNlvmGFd1uW5A1ZORO9tj9op3dptq
	Q8ugSBsy6s0hjXkPWnFnsj+YwDQAN1Y=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-0zs1cGv3MWaixdEF04vJEQ-1; Mon, 06 Oct 2025 19:42:25 -0400
X-MC-Unique: 0zs1cGv3MWaixdEF04vJEQ-1
X-Mimecast-MFC-AGG-ID: 0zs1cGv3MWaixdEF04vJEQ_1759794144
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7900f597d08so1531181b3a.1
        for <linux-acpi@vger.kernel.org>; Mon, 06 Oct 2025 16:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759794144; x=1760398944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCfiz5Ut6f0Hmx5GZ2r8SOtef3xDzej4Rj97vBZKv8A=;
        b=M9/SSMS2mSGCvUda1shmidC2Ll3RlkiNqmAPpeJgQWaRt48qqRFZLQrn7JVhIuuw1g
         gvw0uk4zWlqyukmTBMYxzWF4oGj47PFWCcuTXomRqsx6gPBeRXtjk4vYB9H56jXoMQ0D
         zQVPOmwT9Ix8HwRQQbSuZK9XHzJZvLcnud9cJbw/aFc1clEAQb5I9lK9z1ksbQTvVkfq
         Ssij1OCXvFNZ3GlUVpepnAPOZLX3/D3uGB+2rr+B2xUZw0jgkeQA9FYiflJl3kWBiynm
         AB28p6QWZKqvuUzfFIq9BNJ7IZEA1Pn9M+ypkRa8tkYlskBwnQedP7/e7ku2t76BaBWE
         4QMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU+IOTluoAMs8M32d5AIIFzkuPwCDw/MYw+P9W+pv2jwPVs0ufc/gVrltvejH1/UWRdsPCIWOkCSD/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt03VsBKfmVWt3ooCwLxT89XNw+9eMo784rsniW9eJ1yPF4LVq
	SSVuKdZCRc3gKekmTXAwn6rKlqkU2EzxuWzTueGjt43TyqlvLIRIXsi1BgANmqq0qj3ZJNTiNoO
	7FkHa6u+9mwJiU/qQvuJW27ZuNnUmf1Ehll6G2d+HyooLhSO8lYqbCyDlMo7wVpg=
X-Gm-Gg: ASbGncvF91Q5C0foc1+FbqwnhI8OF1S4zidhKt2edPlelQmzML0WiQDmqEFRT3hjIxJ
	ZUn6WrPCXdx01NU3mdl7OStEZK6I4YjTBG7DGSEfkoZmA9UK4cpl3W3culxXO+TiQwtmk4YoPEY
	xU2FeppTrMF92uYMYT8W8D91+CvQtiuIqYT3lOcycVCie24FENu2uxsKm4FzViYabozgLDoRx8P
	WKoI3USqZTVMzXFLcRSL5j/TbnOBhvKU48wNXbtOriLN9eFyomkcC41ZagDm6ez6IodSiVRCJvI
	6mWOSrhlid4XO5KDHFxUc+adDrweMDaxo/oFDM1EI9Cj3Jq5Rimig3rXc8sseqKy/pgUe4QsNpb
	fl7dKoImveA==
X-Received: by 2002:a05:6a20:1592:b0:2cc:acef:95ee with SMTP id adf61e73a8af0-32b62136d1fmr19762273637.52.1759794143768;
        Mon, 06 Oct 2025 16:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErH3GfkI2IJHSlnVnK9KFQpJaGBBQh0aEIEhfAff2FkMCiATPoRFpGW3jxwgnd3xHSMfVm/w==
X-Received: by 2002:a05:6a20:1592:b0:2cc:acef:95ee with SMTP id adf61e73a8af0-32b62136d1fmr19762234637.52.1759794143405;
        Mon, 06 Oct 2025 16:42:23 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb1d27sm13937880b3a.36.2025.10.06.16.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 16:42:22 -0700 (PDT)
Message-ID: <ea7b2ab9-8115-4164-ba9d-6aa42ac57482@redhat.com>
Date: Tue, 7 Oct 2025 09:42:09 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/29] arm_mpam: Add cpuhp callbacks to probe MSC
 hardware
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Lecopzer Chen <lecopzerc@nvidia.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-11-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-11-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 6:42 AM, James Morse wrote:
> Because an MSC can only by accessed from the CPUs in its cpu-affinity
> set we need to be running on one of those CPUs to probe the MSC
> hardware.
> 
> Do this work in the cpuhp callback. Probing the hardware will only
> happen before MPAM is enabled, walk all the MSCs and probe those we can
> reach that haven't already been probed as each CPU's online call is made.
> 
> This adds the low-level MSC register accessors.
> 
> Once all MSCs reported by the firmware have been probed from a CPU in
> their respective cpu-affinity set, the probe-time cpuhp callbacks are
> replaced.  The replacement callbacks will ultimately need to handle
> save/restore of the runtime MSC state across power transitions, but for
> now there is nothing to do in them: so do nothing.
> 
> The architecture's context switch code will be enabled by a static-key,
> this can be set by mpam_enable(), but must be done from process context,
> not a cpuhp callback because both take the cpuhp lock.
> Whenever a new MSC has been probed, the mpam_enable() work is scheduled
> to test if all the MSCs have been probed. If probing fails, mpam_disable()
> is scheduled to unregister the cpuhp callbacks and free memory.
> 
> CC: Lecopzer Chen <lecopzerc@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * Removed register bounds check. If the firmware tables are wrong the
>     resulting translation fault should be enough to debug this.
>   * Removed '&' in front of a function pointer.
>   * Pulled mpam_disable() into this patch.
>   * Disable mpam when probing fails to avoid extra work on broken platforms.
>   * Added mpam_disbale_reason as there are now two non-debug reasons for this
>     to happen.
> ---
>   drivers/resctrl/mpam_devices.c  | 173 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |   5 +
>   2 files changed, 177 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


