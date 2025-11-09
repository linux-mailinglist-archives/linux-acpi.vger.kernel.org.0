Return-Path: <linux-acpi+bounces-18716-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3470CC44A05
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 00:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC5243462E5
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 23:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D87A26B2DA;
	Sun,  9 Nov 2025 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAzj/dme";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n1lTDU2k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3500261573
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730416; cv=none; b=hdqbzMnnnydv3O5KGtka0cIFEajv3nEG1lRJKMEZq1ODNwX7CzpagG2eOCXCxlAPdXsvjXiC2+AtyFUKx42xzXOy3b8jpnqD5F3+2BfGCUs27UEZUEL/XFBfCWJhDx65+3zeSTiBR+iV6Hz+/UnW5agAFUPLe1NruxNDTe9+35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730416; c=relaxed/simple;
	bh=srf8FKHPA5gT+/Ek49LXDoMTbSdIMVFrSGeNGjTk/gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/j6Wzdx5Aqy3ijXxHbaxhsfzsvx77etR/CjzzyRqKnws0sRHs7dciHAGm8tR109oZnolqUZHOvV762vLa6IdXHnySbCUTV+fwR+sGyac2fnPTBXNvsnsx7z37AdI1Ly9OmZPvzlcQMeOR1js21j1Bzy5RyIHw/BnKL0opdHqfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAzj/dme; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n1lTDU2k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762730414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ub4HwkWXj0kR29vkzdE7MXJ+PIlZjseX2UvZ7umPC1M=;
	b=OAzj/dmepwXVPMUS0Y8e+J0jAZSCotQyoiR9BxnAcJTOP6E6/efFIXZ2F6lrEKlLzRMTyO
	tkNPtQegL8kvOtOk5n8V92F9KA0AvmxJ+h4hLEVoikiYotsEzYP5hz3cEpbjMzy0v6maQa
	Y5Y2p6DRyvJaz7mgA5EZO+63l2EcTWI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Rg80irhGMdCxSBOuEwvOCg-1; Sun, 09 Nov 2025 18:20:12 -0500
X-MC-Unique: Rg80irhGMdCxSBOuEwvOCg-1
X-Mimecast-MFC-AGG-ID: Rg80irhGMdCxSBOuEwvOCg_1762730411
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2955f0b8895so30568065ad.0
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 15:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762730411; x=1763335211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ub4HwkWXj0kR29vkzdE7MXJ+PIlZjseX2UvZ7umPC1M=;
        b=n1lTDU2kJnIqpIAykJZFYq0bqSpm57XtfwZiJ7Tgzij6HZquCvQhgmEaDu+slzgQfg
         2VZgwLcu//2fG96eyeXSpEZW1Zi0ZG2E+JQA9xdSlv/Tju3BRH+JkFRmmtf0V9ZHS/Ju
         qL0ldYLhT/Qhn7QyTrfVikiQnFHdEkM1Hy9yeLjiO/k5fYnuJXBiT/RvAQlShzs8MZ4Z
         svqgIrH19vEKusWhGBnvJgktQJFC6Ezs17ttDwb0KQk8Ax5JiGSMkOta8avZg9cJ0ED/
         RCGSeKQCfTWu+QVcSS/M0+fekCEoFNY+D5+mZSI2J5nbLtqxm9EE+u5MZ9201tGh2xHF
         kYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730411; x=1763335211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ub4HwkWXj0kR29vkzdE7MXJ+PIlZjseX2UvZ7umPC1M=;
        b=Q0himbck6xuCm1TA7GVAe6GCOsKOI6Y4nTgt9BJcvjkm0qAIQBrr1y+NqnG++YpAGp
         h3Z1qEb4Zn5ZUMb3T+MGpy0+zLXsW+LONHBXrwxpe4eZgzCo3RhEqEhrdrm/tMewhRzd
         +JVzjyiRworSvYnMXk7s1oGH9RkAHvdXneH3IwkJfhVSuu+LGU2V3ZMYuhaShS1qawzt
         8dTe5QuskObAx/kSZO25dX6tZ39hZCf7QZo/uUJxeklealVsV7gqG2ezbz9ToILXCDXl
         Co/1xApw/4vEWIEiLURVGwCUPguKyGTQQItIlsjY9rrulf+Q/IXB9tEWu/DxZRxarAuC
         rEcA==
X-Forwarded-Encrypted: i=1; AJvYcCXO/ENyCDxM0KkI2ier1oRoqEER6IgLaMJCwON4iK2JXeKf3KDn0zbKET4PvKTXOZmCrx6zLC+YHNsZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yybg4zBDajAEojIHphZwxnERaWiwu3kg5/7IEBcKRHpMj35p0oE
	J/dWs9+Mx1uaF6EXLeBC3/NNMrt1x3xfvomuQoTFZG7Beu9dfWzhqkfJE9QCR8AJkqM/5JKUSDL
	GV49ibBrvFsN3hYtA8YmCVMxAOrK7ajnmHQSxZV0bkiwMG6D+qFxFT/aD73MHfB8=
X-Gm-Gg: ASbGncswWO36V9YJ9b52BUllED+Ic90eYyEVkb1a17FYI+Znk+Qey3oYeZyJfsiJY5R
	M+C/czNdxW20RB2kokn8v3JZ+IhJyjKSeek3wu8t6zMst1TTplO3+rYNoFJso9WPacZTFgY1YaH
	BkMgtlUbg0k5yT36kL9S5CgsTc7utkhz0+UyaTeWCPgtTLR7FJZ0qRgueRuCLr2bqLWQ0LVqbJw
	1Dj3Dyah8Kk1mV++Y6g9eOzwSimK27VwWB115SYXg0t3MMsRkgz/NIkqNDve0tqDep6fUab7rBH
	ycl+sDkcL2rEAz7IiSvnDvGoqJF4M607akKc/LH6kvjsvrW3Chj6XECBng6bpdFJO9yLze4A7Pw
	8K1taBzCNj2NG/ZBirmUUhjkQJD+smwv1HTLIxeM=
X-Received: by 2002:a17:902:f707:b0:295:6850:a38d with SMTP id d9443c01a7336-297c95b383emr105100545ad.19.1762730410842;
        Sun, 09 Nov 2025 15:20:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfT7bPjU7rlLqD1mvfy96eNWnGcGXX4eCviCus1dyeXGa2C8aUiTh1n4HBCdkV+L+6gpZHRA==
X-Received: by 2002:a17:902:f707:b0:295:6850:a38d with SMTP id d9443c01a7336-297c95b383emr105100275ad.19.1762730410453;
        Sun, 09 Nov 2025 15:20:10 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096dbe4sm122937955ad.11.2025.11.09.15.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:20:09 -0800 (PST)
Message-ID: <62a6e89b-00da-4901-93b0-255c0b72a16c@redhat.com>
Date: Mon, 10 Nov 2025 09:19:57 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] arm_mpam: Add kunit tests for props_mismatch()
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
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-34-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-34-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> When features are mismatched between MSC the way features are combined
> to the class determines whether resctrl can support this SoC.
> 
> Add some tests to illustrate the sort of thing that is expected to
> work, and those that must be removed.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/mpam_internal.h     |  14 +-
>   drivers/resctrl/test_mpam_devices.c | 320 ++++++++++++++++++++++++++++
>   2 files changed, 333 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


