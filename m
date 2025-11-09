Return-Path: <linux-acpi+bounces-18714-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC4C449F9
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 00:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3E264E50E7
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 23:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F473253B42;
	Sun,  9 Nov 2025 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaoKgs/r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fm77B9Br"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727141891AB
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730314; cv=none; b=PkDRg2U3iVFnJiK5hsBfzJ2t3xTv3F928sk2glHQNvZzNHXU5qifcSWZTnMrKIZY8/Q3JHgY7pLYzBm2MElsLoeh8xM7btDjVVHCo93VPYuCnp7U+/hlUDBKyowdiYD7mj34blTwkvgYyCWXRr9E/alkdyf/v0l6DWiYpLLe75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730314; c=relaxed/simple;
	bh=jVRwO6u+KFtMJdZTz0EnPMtiDoeQNjIrcwl2T1le3Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYRx2lMcR2TnknxuGMeu3NPvrBYW/NsFPRXp53NiO1qwjnWOs563PE29Jv163IsH/Q5+GNlvKNR5E7Ym6pkB0x5ECliLTnnCFjy1icIAORohUW62kX5n4nSvomTQMyFGlCHZNPpEwpQzRFp+s2nml10cUAt9jo82fUMyB3tlryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaoKgs/r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fm77B9Br; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762730311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n99PJkbrVztG5y0o6lXl7OvJ8hPSY/Pukv4ngg5F/xE=;
	b=iaoKgs/rG2d58ndI1ZrSVgPEUZc+6dF4PiRDKIzhwbn+yR2gUxmpqBoxHHoeC0ehIB+3WH
	dU71I5BTOyKhKA2x6QCsw1CzhKVIQC8UtA679G5+ZLbb7qZW+d6pGGi6qYJai2gD8aFxA9
	IKczxz8XWCzmgXxtaMBRVq0RtOX0Buk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-vleOYg2wP4-ZWySbIKbEPA-1; Sun, 09 Nov 2025 18:18:29 -0500
X-MC-Unique: vleOYg2wP4-ZWySbIKbEPA-1
X-Mimecast-MFC-AGG-ID: vleOYg2wP4-ZWySbIKbEPA_1762730309
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7aa440465a1so4947974b3a.1
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 15:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762730309; x=1763335109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n99PJkbrVztG5y0o6lXl7OvJ8hPSY/Pukv4ngg5F/xE=;
        b=fm77B9BrrI2sHWOek3VMQc6AaL8nEEwLYsqjA2KSxKFUkjQQUiK4Q6n27Ms1Qhxux5
         5/VV98Jgw4tsZTKQEtX/2MiNe7CFWYmgEXAX+5Uk4iNqCoPoHY1YefFCgF6jLTVDA1Z/
         O2NU1i8YKTZLvnip9Nj3tYczQ2TPoL572UOP5fwWFWMHlvr7iA8VuIoZYmghBGJEvnNq
         IwGV1ibEgW3ZdTODecH+TSzXs3smxTTvODKysoklahtZGT9nnlsDfEh7LIWRnF+ti3H9
         pp4NqG/8JLiJsco3MUlBWjGxwvWtdllv+wPAupe1CylNwNtgfOoF9psenvXBdM29JW9u
         8cNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730309; x=1763335109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n99PJkbrVztG5y0o6lXl7OvJ8hPSY/Pukv4ngg5F/xE=;
        b=HCJECWEuOVzzfxr68aSQ1z95PVQzEkwmCsvZAG+32XYS6GVFqqMnxyI1OCRA2uPErH
         r6vx8uBB3eHvDLY7H+tKoKHZhtAn1Y9GXh17jdPj/gvZgr8yepB55ALK583xWYbpOaPG
         qhbEQM7jFNSqefI3koK5MKfdIupJxfMuTwa2gImjli9noh15OORuZnZGjCjaTyXnNfOH
         9WW4gmJZouwnXT1CyybRh/zDSMpejyWG2WqnBQIA9yWW9qqzUnsQeD3RaY5AYQkRUlp0
         DRN5xWKKy3eIoACKyHPuLfHEHN8WeoAYN9u3Krb8nz7HfyHzJnqSO1H8JLqUvawK2wer
         lEvA==
X-Forwarded-Encrypted: i=1; AJvYcCXT6p/X3NhUs1/4ESCbZnDqJERmW2WHDNFs0JepZ+YCoJiUPzYtAfqTDesAYVoR/YGu2A8D119ymhTL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+McXLFqWAL2bCY1z9fxGoCBwX1XrOdPq6Q9uESed4FCNShTk
	2ohgI/xrscNLla9kX/BuW8fwVr3lN7HqZccvEpV7NGIZbb5+xd1hTghHsZWCxX1a1plkVX9mjlR
	xNAVWrbS3cV/+6SNX7sKqGUI5uSdy2/Xp6f+h7XXSm2T1h3b/dAWR7G41nd6Vrjc=
X-Gm-Gg: ASbGncuJSFqg6bCa+JcWLBXG762oPyq7hQp7PuAAcYDK6uZFQG+3Nx6zRgccAaJQgcH
	KqR+t4jqZGR3/YkMInzwcl7GivXgQRqgs4VRPa+xPEU8u1HFOhG3y4GSErDIz9CF0JjmpoSkpmW
	d5o6+jCUjBsNu3quu5xhry10Ig6CzMC4PMw/8YJ1lrxHXvTviDhU0BaeVRC/Fq36dJiqQiYv7oe
	dTAsKf1IfDU9em8SPZMpHw301jJNsyC2Tj9Ou0Vg82Ad614R9+1IqSl5LOSNVkeiTTJP8X/qnVY
	nDab9NsLBVUEBLn7/1d5lV5u9Wlvr9mYahrt98Gs5Or0qwFVD5vSII/WOtcbO+mGwn2QYHcbhVx
	4IoXzTAbpeliD/E4bXGFQLM+ShDKcrD/EvtTLQYE=
X-Received: by 2002:a05:6a00:3e1b:b0:7a2:6485:f336 with SMTP id d2e1a72fcca58-7b226696673mr7522423b3a.16.1762730308736;
        Sun, 09 Nov 2025 15:18:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2mSuUUE/RVfgQqmRz/YBiUVDNGBy59LbywexIFQuJ2RZ6fbmp3YuWDNYpjDv3UjdhEXNI9Q==
X-Received: by 2002:a05:6a00:3e1b:b0:7a2:6485:f336 with SMTP id d2e1a72fcca58-7b226696673mr7522389b3a.16.1762730308356;
        Sun, 09 Nov 2025 15:18:28 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c08ee9sm9664548b3a.21.2025.11.09.15.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:18:27 -0800 (PST)
Message-ID: <67a36e6d-daab-479f-a1c5-3b2444a71d7c@redhat.com>
Date: Mon, 10 Nov 2025 09:18:14 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/33] arm_mpam: Add helper to reset saved mbwu state
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Fenghua Yu <fenghuay@nvdia.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-32-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-32-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> resctrl expects to reset the bandwidth counters when the filesystem
> is mounted.
> 
> To allow this, add a helper that clears the saved mbwu state. Instead
> of cross calling to each CPU that can access the component MSC to
> write to the counter, set a flag that causes it to be zero'd on the
> the next read. This is easily done by forcing a configuration update.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvdia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Cc: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Correct type checking, use mpam_feat_msmon_mbwu_<n>counter
> ---
>   drivers/resctrl/mpam_devices.c  | 48 ++++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |  2 ++
>   2 files changed, 49 insertions(+), 1 deletion(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>


