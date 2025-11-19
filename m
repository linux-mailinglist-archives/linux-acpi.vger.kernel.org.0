Return-Path: <linux-acpi+bounces-19054-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF32C6CA56
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 04:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2F8812C7BC
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 03:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5A02F069E;
	Wed, 19 Nov 2025 03:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Adkn7d/q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvuqPEtR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683981FBEA8
	for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523870; cv=none; b=QHe9uB+1D29HIpo2sSP1MvvUAxwfseW2Sk4n19ujyVvO76rpxjyg2pJHfpTZvqrk2U5vqXMt178kwBZ1NEFs+4RVVrM5o11yuo6+l6pSNWKkA2MAWvOE4NiAR82XDRcvOLZ3AafHeszjon7nex85gItJEMjPt2MFGcsuBzgcqNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523870; c=relaxed/simple;
	bh=z92rclzfZjPpwfYi567BVsPQsNnWEk4kPiZF/MvGZaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJ0EIzGCO/E/zW+WgViKN10qPndhaUfdjiGvgNEenRaMqJuBjKGHylzxo3A48G573kFtpE/YZz46T+95HWuaZbxewKcllUXsCZkFob6ELy/ea3Y8sHRKL4gtXfLC/W60C1hegIcschoZhYNNzclaHgaC7jc8mxsKCJv8OpPVL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Adkn7d/q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvuqPEtR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763523867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=prLgl6MqKaOVE5KSjEpfN7vkyzgDDcx68opWuG8BQBs=;
	b=Adkn7d/qilipPR1tsvNuB6wy7zG9uBVEri1ND8NOeCVQowgtl0io8+Wonheu9+zeXVUNua
	qYdm1X3eQjKDdzP5H+GU1xqqZPYbcbhEXcc2RNKQy3mqQQntklowznXH9mOJzyUyF43gEO
	3OUnpufJwTJZdBWn+wvgyKAjAoe4MU4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-uUQ1JPy1PGObdM6UI4ba8g-1; Tue, 18 Nov 2025 22:44:24 -0500
X-MC-Unique: uUQ1JPy1PGObdM6UI4ba8g-1
X-Mimecast-MFC-AGG-ID: uUQ1JPy1PGObdM6UI4ba8g_1763523863
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34377900dbcso12293396a91.2
        for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2025 19:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763523863; x=1764128663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prLgl6MqKaOVE5KSjEpfN7vkyzgDDcx68opWuG8BQBs=;
        b=KvuqPEtR+2g/ALqdAGHQ2caWerLVcd4lBp8Fhw77PCND1fMc5rNpsIH+2OwCa73UIT
         izVg2XCUTsulLDcTvjyZo3JP7rM4+B8IWplr/eNK7G3rmYluxK3Qgip6TP0K3WFW1A55
         rUKhyE50Xmy0pNcCFXbJg5vqotpoXg9aEx3HwGBtS3qShYSNqZNYg6wITteMkSM2BkdY
         jbWCh4dwxZXbNMe1XMtoJ736JvEsnI4QBccFoVMbdaRyxmMbJwUF5b6fEc3FD+woozYc
         2udf4+Kidw/BMU5w8/mLqUbrqUuC0yi9aUy7RlHrxQaK60ekUSKHbc47ZuOi3zbldwsj
         hfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763523863; x=1764128663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prLgl6MqKaOVE5KSjEpfN7vkyzgDDcx68opWuG8BQBs=;
        b=qQjG+bdSqh8Zu+UlG4RF9ne3Z/KUifkV5hzh1p3LikybupRQuqQvwC9TO/Ra5bx8AX
         oeau2HwLaVqGm82ubNCAgOvREfiqOkEADlSoB5by3zbzEHg44Xe3MJBcV8BXOG9H25dB
         EI9fh+rPBzFwQ+usNT6gT70OLeGymbg/yBK9hnVzb8k83egiSCGLQHX1F/jjxzB92smO
         VXGnoz2MVMFuFueEtxWpnYdebH7m6nLeys2FaBdnTSujcDIoSLWvRvCLxXrK2mnwOi32
         y6TO2BiJNiU6FTbhjVaW14Gw9kTQnXR7AlCMBvE2arXWUUHhW8Dq7wbHu5BGUycdiLK2
         mp3A==
X-Forwarded-Encrypted: i=1; AJvYcCW+t2dN7s/a7av54mPSIiY11Z81Zsrhm9Rc7Pnjvyscnhapdz0VJUlJsd12o/TUXfRMcd/VeE2Hnxjg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6avjqyCf12/ptHLxzgBxfEtZyDo/0/7FzNTeM2ZKlUVJ8LF5
	mbCfGhJBvvimqUAMg6e8IrvmRs1zeaKycPn/3R5BIueY1XbOK0ERjo3pqdpYC1CEWk+rxWYCxkg
	+/wbbdoB54EYHydApTBWy24wItvOVjc6vfi3+dbqzS2FtBaIh+AC/n/pU5ZdX47k=
X-Gm-Gg: ASbGncvWedf2ymbmIZPDPwlPySATEe97ru+HvLI7UcfvWM4txAkPBPuC4AB14LyI/OB
	XR8aNa/EecbAVBvF8sX+eHsbJZYeqzKDuAAMpWONvCbSVe9FXdRt+GTqiyRfBrqd8T0Zt+BYtHJ
	PX++wx1v23HDf3P6NqlF0a8sA3nBxdEh7tpNYQ45a/UBC2aJLq3TvyVevWDoSRZz7weWSPebUuk
	w2YpoymBCQrHZslL7Z84GWfmdDDdvFgvc/x4QSye/7eLFKGlH7Wwkcmk8TwkVjE3cikSR7NsRbk
	DxX9x57sb/depoGg/w/9X/qeJKhc2eGM4Jin0p+z9O2yBWeT+Zagz8gI+UFEeTTTrmI/wXCd7n4
	C3hpqQICeMuC80wf1cHkM7NIE27ahfRN4Ydx40S91ztpyL5Iytg==
X-Received: by 2002:a17:90b:43:b0:340:a961:80c5 with SMTP id 98e67ed59e1d1-343fa74ce0bmr20253214a91.32.1763523863001;
        Tue, 18 Nov 2025 19:44:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCPaF0H+Jz3OKZzZRR2B4LB6Uwpn49QE/z8bW2XWb72TbpGcG24DOc2ShElNamBlge7D3fiQ==
X-Received: by 2002:a17:90b:43:b0:340:a961:80c5 with SMTP id 98e67ed59e1d1-343fa74ce0bmr20253190a91.32.1763523862641;
        Tue, 18 Nov 2025 19:44:22 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345bc111e72sm952775a91.15.2025.11.18.19.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 19:44:21 -0800 (PST)
Message-ID: <9f2e9fdb-0101-48c4-83cc-66b291299498@redhat.com>
Date: Wed, 19 Nov 2025 13:44:03 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/34] ACPI / PPTT: Add acpi_pptt_cache_v1_full to use
 pptt cache as one structure
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
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-4-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251117170014.4113754-4-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/25 2:59 AM, Ben Horgan wrote:
> In actbl2.h, acpi_pptt_cache describes the fields in the original
> Cache Type Structure. In PPTT table version 3 a new field was added at the
> end, cache_id. This is described in acpi_pptt_cache_v1 but rather than
> including all v1 fields it just includes this one.
> 
> In lieu of this being fixed in acpica, introduce acpi_pptt_cache_v1_full to
> contain all the fields of the Cache Type Structure . Update the existing
> code to use this new struct. This simplifies the code and removes a
> non-standard use of ACPI_ADD_PTR.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> I have opened a pull request to acpica to update acpi_pptt_cache_v1 to
> include all fields. https://github.com/acpica/acpica/pull/1059
> 
> Change since v4:
> Use fields directly in acpi_pptt_cache_v1_full
> Delay the casting
> 
> Changes since v3:
> New patch
> ---
>   drivers/acpi/pptt.c | 47 +++++++++++++++++++++++++++++++++++----------
>   1 file changed, 37 insertions(+), 10 deletions(-)
> 

With '__packed' added as pointed by Fenghua, LKTM.

Reviewed-by: Gavin Shan <gshan@redhat.com>


