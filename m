Return-Path: <linux-acpi+bounces-10876-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2A6A24E53
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Feb 2025 14:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076D27A1B92
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Feb 2025 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543591DC9A5;
	Sun,  2 Feb 2025 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXdkDkC/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CD51DC985;
	Sun,  2 Feb 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738503855; cv=none; b=P4o16jNnDvXA5/q3nxmnb1Igiq63ljeiIk8fAWMyvoSlCel/dkZrurazsFvEjJUuoWfvXrbsejPt7M6PcCBKjx63SHfNi2wvsrMy+ENsEHZ0VZS8qlmzCrPeJBIjk5MM8TpKo+L/X9tHsl58kjRYIFl/h1P2hN8gfGtl0OoCmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738503855; c=relaxed/simple;
	bh=O/LkhUAjYB7Cqep4qBvUPr2jUPzG34C/1TYkKfkxteU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pP0Wzg4xBNfXXyyVF6px2ISNewkzku1s8CJXTirFG10rSn/WutFHulbppiv6UpD+gopB3dpkJZ7vMAbxXSIFSrpzFXhwWfDwIsaOa52H5pR5yhpFqr2yx7Vs6MbgzqJ6W2TmbS//nnczZEdxl9eSQE9js9hCoQVDqNTPSs86HyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXdkDkC/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2efb17478adso5884004a91.1;
        Sun, 02 Feb 2025 05:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738503853; x=1739108653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzayRBbvjFKjGTEED8m/pZVSLWexcRis3+D6NjBXPsQ=;
        b=PXdkDkC/1IF/cDzuaiyf/4/f3q0b0JrpxWdkhUoeA+jZDnWs/vkH+sa92I9elYpmHQ
         j6qhS8EAOZ0GyCrdlZZ5fr8r2tzlVpc9AriyPmErjQi2ysSYlPiXoXjs8S5xoNaB1bgH
         ro5opvyGQIppGj/imZVKTHYMsujACXFQ/ngckg70IWvb7OQXlS8zvsz0IG0Q4Gu2oasw
         X98xjfdbI9JJG/WlbtNUgyCr9dt6t2dHPvxTnfL5lxdUqd0OerR2FGNYvJI8wwFkJB89
         MoMmkKe511SgPQdbUyTIZf5JT6261mGptIlNcG4vvMrGTe/JveWFZFTHKeOWsQU1mfqK
         XP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738503853; x=1739108653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzayRBbvjFKjGTEED8m/pZVSLWexcRis3+D6NjBXPsQ=;
        b=QLrk+Fe1+fxcq5L2anN6hP6Lw/Z4l+f4Mhmfi5EOb8J2Zg1tne2fR8Ly+8rZsHDiDL
         LhR34PHJiXBmFNqD3QEj5LWwXe3qDOTCxd2WyIgJcqSWBTtD8iVQPt7qgYHhSHNoU0Ef
         q4uOoYrSubfsskPwoAstDGQluJlUf1Gqef3WIHDwyr8ZiXJatPREaD2qGVW5uMMjsrr8
         sXnsTwm+FWiWRWfc+vPRUSgqFEfb6NpnyBuKOjfP7W5sXfhWq09+NraJeBuEQ2qr7nvd
         qcrpxddiQbT53L18WmKoiwDEIl07SPgNZ03ny1s7H5zkJPXu0/J1Mf4geZkSuMKC4VIV
         a3jg==
X-Forwarded-Encrypted: i=1; AJvYcCVLu8sw8Sd+XCz4guW1uksWk8A/P0Yabr3OsDUZNL4cKKeXOdV2bDeqkxgUAmP5g2KfU8uu/421AdGI@vger.kernel.org, AJvYcCXxP45Yf94VnEzuhMI0O450aSMoHtJMgYZXNvjXU7QI7iWbSk0FticjqhSz38Skhn7+ZB+Q1+k+W68CSHf9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9jv3GGS+9z8OMLBr+BijYfzeOVv8tPXwSxzGFiVJhsFJWsntt
	kGPwHQYX41RWkJX3KGJwMkHDHtUJ/sylGIJYUD5ysiskNLSllMVa
X-Gm-Gg: ASbGncvUg4SOkqNZgtx6wgqLqJZU0TfclnQHTvHqgJIq8SiDI2tawXTJp7glAE22HNT
	tmmLX59XTBXmKxKxV+fATMtTRjtjfok7lBR6bhK3bq+iO58RXTEl+Yw4OfC/cY1hDpzWyQ1ax77
	oDODKaREYgwrPwY3r94cgrM17xEVZwUjjoAUIBQG8eZ4JPKUnSuUAyTRlkWkJfDMR9F2r1pLo/Q
	BVB7+HAWIEypkSt6nvPTAXmLEoVOvSx81C7SRfS6yPoo7w9oe1+7QYlyQM+ivALIz02dX81HvnM
	/yPj2TZbJZXUc/QKA+9LOm7U
X-Google-Smtp-Source: AGHT+IE2Fly974HNmPVReSPAvNlmMHkie4rvpmMfKb2bISi08MYI+k2dSZHMQcF2g9Ibx4ZnE2KLiQ==
X-Received: by 2002:a17:90a:d610:b0:2ee:b26c:10a0 with SMTP id 98e67ed59e1d1-2f83ac5c2a8mr28211494a91.24.1738503852901;
        Sun, 02 Feb 2025 05:44:12 -0800 (PST)
Received: from [192.168.75.213] ([116.121.188.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32eb43asm58792795ad.156.2025.02.02.05.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 05:44:12 -0800 (PST)
Message-ID: <9f56bec0-b35b-4ea2-a212-5c50333c00f9@gmail.com>
Date: Sun, 2 Feb 2025 22:44:05 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Weighted Interleave Auto-tuning
To: Gregory Price <gourry@gourry.net>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, ying.huang@linux.alibaba.com,
 rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org, honggyu.kim@sk.com, rakie.kim@sk.com,
 dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
 horen.chuang@linux.dev, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
 kernel_team@skhynix.com, 42.hyeyoo@gmail.com
References: <20250128222332.3835931-1-joshua.hahnjy@gmail.com>
 <41ab5a11-f8d3-403c-9d68-33eb15aef8fa@gmail.com>
 <Z55QmybX5IkuLv6Q@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Honggyu Kim <honggyu.km@gmail.com>
In-Reply-To: <Z55QmybX5IkuLv6Q@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gregory,

On 2/2/25 01:49, Gregory Price wrote:
> Hi Honggyu,
> 
> On Fri, Jan 31, 2025 at 11:23:34PM +0900, Honggyu Kim wrote:
>> Sorry for jumping into this discussion a bit late, but IMHO, setting a
>> newly onlined node's weight to 1 can possibly make the entire weight
>> ratio unbalanced.
>>
> 
> This is only the default for either:
> a) Manual Mode
> b) Auto Mode - when HMAT/CDAT data is missing
> 
> In manual mode, the node weight in /sys/kernel/.../nodeN is present
> regardless of the online/offline state of the node - so it can be
> set prior to that node being hotplugged.  Since it's in manual mode,
> it's expected the administrator knows when things are coming online
> and offline, and they have a clear chance to change weights such that
> a 1 is never perceived.

This may be true, but system admins can hot-plug some nodes without
considering about weighted interleaving.  If weighted interleave is not
their major use cases, then they may not consider weight values
seriously, but some workloads might use some weighted interleave APIs
that use all nodes available.

This might be my imaginary scenario so if you think it's not realistic,
then you can just ignore.

Thanks,
Honggyu

> 
> In auto mode, the node goes "online" after HMAT/CDAT data is reported
> so users will generally not perceive this default weight.
> 
>>    1. the auto mode set the weights as 10:5:1 for node{0-2}.
>>    2. node2 is offlined, then recalculation makes it as 2:1 for node{0,1}.
>>    3. the auto sysfs interface is set to 0 to make it manual mode.
> 
> If the user sets manual mode, they get manual mode.  If they don't
> want to manually adjust weights, don't set manual mode.
> 
> We can't stop users from doing silly things
> 
> ~Gregory

