Return-Path: <linux-acpi+bounces-18702-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2674C448CC
	for <lists+linux-acpi@lfdr.de>; Sun, 09 Nov 2025 23:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BFB04E39F3
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFFF23C4E9;
	Sun,  9 Nov 2025 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SP0pEs9B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lMc/KIhK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D64A33
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762726425; cv=none; b=IZ5hA48TTw/O7C6Sg998ZSaSJYVguElEnFg2JSTUL7YEsbsf1pRRhWSoI36e9BldKcRTsik8S+HJ7XIWmkhFBb/EZI3erDnUjik0mpW1FFC5S5E6Yw6Jb9bO3UGVMSdB2XnJevqKjNQssDrSzHLMKnzfYUqMXzvJJYQj01guL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762726425; c=relaxed/simple;
	bh=kqJAIdbcHxKuX80fGRfNU2VWUZKbwaHAR5nHv+hbTTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=La9fMJao8h+3Nf3+z4C7HXAT61eOddC4zC4/Zi6nT4m/xrV7qYAkVVDFdagU9JRFH3KgIFpTwIzTNgCIKo9OS4veBLvFMZEpqs2/z+O5ImQ9bzsjIjetbM3Kc1BEfEXiT+V03MHH2zP52tcymc329lPUBtseh+dNLG85clRzDio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SP0pEs9B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lMc/KIhK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762726422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1khi8+SBsdLtnYEbz8P8DQWF/VnSE7LC2X12JEweD8=;
	b=SP0pEs9BOyPNL5LnlzPb/bAgM8AcJjHHJ/6FKIs5pnqFieWERuTCXXc+EQDW1T8OKUIE/M
	Zpj6jh71IwKxCONOIwgt8eC+4TdsrqVMgaeR02J0ubRSGTn+5ZREVEh5cFdL3d+tcHpBDd
	lPqI24HwflgFsRIJok+05oGyhoxV1YI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-11BuDynmPjq5XbgOJ5DwHg-1; Sun, 09 Nov 2025 17:13:41 -0500
X-MC-Unique: 11BuDynmPjq5XbgOJ5DwHg-1
X-Mimecast-MFC-AGG-ID: 11BuDynmPjq5XbgOJ5DwHg_1762726420
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so2029914a12.3
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 14:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762726420; x=1763331220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k1khi8+SBsdLtnYEbz8P8DQWF/VnSE7LC2X12JEweD8=;
        b=lMc/KIhK7Un8ANRhZMPaKhu4kt9fmFo2OclfHvERw7AITZnzqJyDASpoR7x043n/RQ
         u4q5/gNWQmevL8DJNACRXs9fjoczPPxHzIvkfWNvY6ilaBHrxvTVt0mhHYCJLX+ZPo4U
         snNa/3ab4wR4KxpuffHC+0a0tzACKCSZ8UXqk2ZQT8K+Lkh8/i4HlD7YsNkNIDrl8mjg
         0zpr24o7/qme+jLUbLWVOpMbvv+voIFUp7Io/vMxtdjfPpz/IWZw8xW120qXo1MrijOI
         2txWyNZqPuWqiiLBJmLC+FAuDDhzIWxSlCJzyfiaoxf7cYSIPMYkdddNG72BZlq9u+L3
         10Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762726420; x=1763331220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1khi8+SBsdLtnYEbz8P8DQWF/VnSE7LC2X12JEweD8=;
        b=D7tEzPEa/dTjTFh4cTO78RNQumbtCIJRK8SWcXtLrHQDlV2kFLJHuCwiu69CGE85PQ
         U7Fv4D0xAasjnVJ9teakb7xTZAHG3PMOEb0MOF8SO/Bqis12qtb2sazMm2CYh9fJo80j
         AwrFoEORNHo+UIDYXM33zv5+X0AOG33zPxXla83sAGpNaWsUVXirel8eL2NUTrIV8ALC
         MgVVoOkbQuVmRWrJYURkCj7rEdsRrZsyUbB7yYdWS+BGbEfHDEOIsv09RjmTJZQBJYRJ
         AgIKcDTn7TIY7PuS1L7oTXzr5PxIPjx4ebELHyfpCEpcCW5mwmcx81slnZzgpD37/Bt9
         +nfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiR2cU/fnK1a6gKolV/Jr+aPFa6YJBpKrza3nv2NLnBCTUTqjdSdWI/aC5zenHeiwgiDlHAe00EnMS@vger.kernel.org
X-Gm-Message-State: AOJu0YyhN0G1Rp+uHkNn1Fikr43EXAvZgiQx9IQwDwblQlo3WJEMFj+2
	ZpVsDe50y3gcHrrrtX6MaAKJlLhXW6VC0tOA66g2LRxM0cpMtraNrkUZEr/n4Q7sVhDtqiAM2ZC
	EQk9FM/i9a6HwQ5XfKPaFikHaRJ/vZRj5+VeCXovu8nYumYBui5v8tAqnMQ7uAok=
X-Gm-Gg: ASbGncvsDmJv5W/0Cj3VmRqW5aIDY4shDL0SfPlP+x5Tch6k5k/1QLGX206oqHXy3EQ
	RbkOr9GRlc7xot60lNp1HJNCFrwSiHGsJLR6KNkPM/w5g2pOZM6Gs5Bu49x9Ul56dnYhxswl7Ui
	0nnasNWHLW7yB1HgRnqEy62w9ZlbK7RMOwbzl9cB6OSzeB001g7IyURFMlZYzn9c1x5RlI3C2Xl
	NtdVngfnXRIYQiCjkhtPbwxTvsH2JgnfkgD5WoJFJaF2GFVD6xrHf0WkmzoFqkO9RxqucvbqeUR
	jeV4rvO/wrCxlvDLHaQSYslLj+DW4AVdnErtHPDkgIo7XW+LI9iwoGM7tnBY8yy8tgvE5tkprYB
	ZKS1bVFTyvIPybwzverdFXbEg2kh1HqCVgM8hUzk=
X-Received: by 2002:a17:903:3c4e:b0:298:2879:fdf5 with SMTP id d9443c01a7336-2982879fe66mr5263275ad.61.1762726420120;
        Sun, 09 Nov 2025 14:13:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGb4XxQvoeJ0W8VROpZXADL4+iR0errP9SCVp5LKwsSJ4XS5XSp4nkIxyN5gwkjzdnJusKqWg==
X-Received: by 2002:a17:903:3c4e:b0:298:2879:fdf5 with SMTP id d9443c01a7336-2982879fe66mr5263015ad.61.1762726419763;
        Sun, 09 Nov 2025 14:13:39 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c6f20dsm121120615ad.65.2025.11.09.14.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:13:39 -0800 (PST)
Message-ID: <290d5834-65fa-4200-a76f-356a754c3f06@redhat.com>
Date: Mon, 10 Nov 2025 08:13:26 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/33] arm_mpam: Add a helper to touch an MSC from any CPU
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
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-20-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-20-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Resetting RIS entries from the cpuhp callback is easy as the
> callback occurs on the correct CPU. This won't be true for any other
> caller that wants to reset or configure an MSC.
> 
> Add a helper that schedules the provided function if necessary.
> 
> Callers should take the cpuhp lock to prevent the cpuhp callbacks from
> changing the MSC state.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c | 37 +++++++++++++++++++++++++++++++---
>   1 file changed, 34 insertions(+), 3 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


