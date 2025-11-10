Return-Path: <linux-acpi+bounces-18717-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2C1C44B3D
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 02:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15013B0228
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 01:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB51EE7C6;
	Mon, 10 Nov 2025 01:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWIyNVUH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jhJoAqPF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03383286A4
	for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 01:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736631; cv=none; b=SeCnwvt6HyYDSDbW1PgesTuwURH+X9FZXHKMgTrhjD6zaPerzuDKgvDu4vXzJ2nY/7TwDUZSQnHut/upEGtud2v++v09aYQKKysPM3BtpNOjTd2lnBUFVvlakilGQMGh0Qz8WVrofsCYCkWrJU0O8uJT6mrktM6JZlKGDj5xA5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736631; c=relaxed/simple;
	bh=vC7Qu8mrxzkCPxU8hIL0SO1Mmh3zmsPEukVxDCbCCj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=draUo8Nq9fa2qLBJQWsjZQx6Kc0DKqFmHau1wy/l0qrb5hIfFdTBmMFVb+g9JBsPnQFCLHc47DPo3s7iDUb+/T55rWprQ96QyZ0m9HKwkCedsnF1cGyvN1tIBhxVkal3mFssZJSBsCyv8+N7GoIiIT1Gh9sFdLVcYbQYZalFYp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWIyNVUH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jhJoAqPF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762736628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fp/vQ8A4fCVWTHL4CZ8vIUZDQ6q0Bi6AYYIP+rrLgSM=;
	b=HWIyNVUHDJ0qT0DU5hk5ag0E/h5RzKT0tCEdwvzBKqjPPrSMOqsZs3q5cDE8k3dw+d2chL
	lX+5jo5Z+Kk7hxgREhmnnuIx7toRgWR9wXgZULNZCBvOMBLG6nEjTaoQqh3tSPGmSH0eMu
	DXmnbo6B8hOprpRxY0THNcxMuuXwDYk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-N1vQwF5ePJeuS6-FK-wjhg-1; Sun, 09 Nov 2025 20:03:47 -0500
X-MC-Unique: N1vQwF5ePJeuS6-FK-wjhg-1
X-Mimecast-MFC-AGG-ID: N1vQwF5ePJeuS6-FK-wjhg_1762736627
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2958a134514so27483595ad.2
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 17:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762736627; x=1763341427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fp/vQ8A4fCVWTHL4CZ8vIUZDQ6q0Bi6AYYIP+rrLgSM=;
        b=jhJoAqPFITQeIx9A9Kyp5SBFTc9w3S9hh9uNDwBPt9oBr38H+XPIctkhYHnQUnj68b
         i/Aywohpie8E695dT+OK1Easr7G2y4YYDbs+KmWx+9whVfdw+5EDvI6gko1O4AdpRadC
         p/56qI5wyClnwH4/XrDYEeSF4f/hSs2CZ6rkzZhzaGwVfNkFfgZb4sRAnBrp8bYYWfOL
         SFOzGlGVFvFh7rEIBUtwY7OnEsCPMbsQe19Hp3e6z+rE4dfXdoYaM2DyqwE1IzaVaWrC
         HM/tsNjbhdKu30Kaja+vSo837nRpkG9v/K4TLcFFIekima42zPzWQluwDdXhA/revCN2
         HOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762736627; x=1763341427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fp/vQ8A4fCVWTHL4CZ8vIUZDQ6q0Bi6AYYIP+rrLgSM=;
        b=XDi4hukXSvhBQgqtgbQ2QiWbcvv+tCUnHD20IXt2kYG5fhM053ZlY76/Z39W+IKXo6
         XZz6EwM3zR2k0wqJgski+ayo6hVYmc5Okt4JtiDorFVHB9XdDPBHBU+yN9AI1qgGyH9a
         F2DM0Ad5ZIzqfyOAryiEziEMgx94WeGwP89l6SbQ/1Jt9/gPN0GykR7thyaCLEPXEuPv
         zUb0WKJUhvtz4MT2XrYtXY5pZYNdFqeLAS1ihBVBlCw/UTj0bO1T0+sbDzKYek4NmrR9
         CckJZ3TX6qd5p67lo7YmVigbT+UYW0+Pb22Sc9ruBcPI2plhE+UrxptNUl2n3ELVx2uC
         K/jg==
X-Forwarded-Encrypted: i=1; AJvYcCXno5A07xFqUwYYEVXvQo7pI41jxlP+6JAleLWT+GFZy2Db9eWVwJYMRZ/8e79VoJuRd1krNDfpjBxR@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGoLWHO4bXAmLLBGHuuZaSAX2+VBtXVZaZ1YsrgZUnU2ME8dr
	uO/PfD+3WDd3eoFz6M96v/M/Tv2loyyg3ZfdkO1/5xN5a7rmnMO60NyX9qDrKUlWP5BKTPQ4SEs
	jwDcamFpaCLkPHLXQX1U/BNqZ1hbkLs7hmSR8XwOyIhHl1YhSYlczEdhYbikU4JM=
X-Gm-Gg: ASbGncspMh5RxcsCIZnQGQwElwFqFqJ4LDva/N209eWuDUDWmBReS6pXbz1f2kO6bV+
	5IZxNEjrY4wmWB62NzXGhv74tDwwdqzjaaTEzxLLgLhsGa552HVVWh+fl2SwZIwVrOMcklo1cdv
	aY/IyYQVsZ4rrwSlhNOtJarcaKd9fpjPZ8rH4iGgxwDXH0VMK2/r2SxDvV1EKWRs6XWJ9Khsho7
	ftKAL+jSMWL1HiFR3gfn47bUfNYb2wAcTVNZJ7c1Tw4YBAodrkhEectbOjtVwEf9cY3SLhuef32
	bhD3fNhbSbxJ231WSKRTV+3EVjk2RvWiCRnQ6lltMVP11+m24cn5xfk1SPvRadDFZ84g6Cr6nkY
	cDTs5rk+tEkpr0VDv4knPyAy9VqFlfLd/x+b2sfk=
X-Received: by 2002:a17:902:da4b:b0:295:24d7:3792 with SMTP id d9443c01a7336-297e54030a4mr89617425ad.1.1762736626584;
        Sun, 09 Nov 2025 17:03:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEflOEbjXKgiwLnCEBh3CST680cF3GuQpNEfibt8t7UBtS7/A/XhpJnakWl13KtFWAXgEGWHg==
X-Received: by 2002:a17:902:da4b:b0:295:24d7:3792 with SMTP id d9443c01a7336-297e54030a4mr89616825ad.1.1762736626020;
        Sun, 09 Nov 2025 17:03:46 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e3c5sm126117355ad.43.2025.11.09.17.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 17:03:45 -0800 (PST)
Message-ID: <8a382455-1915-494e-8cde-04407696cfa9@redhat.com>
Date: Mon, 10 Nov 2025 11:03:32 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/33] platform: Define platform_device_put cleanup
 handler
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
 <20251107123450.664001-8-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-8-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> Define a cleanup helper for use with __free to destroy platform devices
> automatically when the pointer goes out of scope. This is only intended to
> be used in error cases and so should be used with return_ptr() or
> no_free_ptr() directly to avoid the automatic destruction on success.
> 
> A first use of this is introduced in a subsequent commit.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   include/linux/platform_device.h | 1 +
>   1 file changed, 1 insertion(+)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>


