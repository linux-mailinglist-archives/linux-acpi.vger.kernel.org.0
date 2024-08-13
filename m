Return-Path: <linux-acpi+bounces-7547-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1700C9502BE
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 12:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE921C21ECC
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D63A1940BE;
	Tue, 13 Aug 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikrdPgnr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0CD19AA73
	for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2024 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545918; cv=none; b=owLy6L7Pka/58LEBT7X2vX4Vm2j35gozGqEn2RS3ZqMLKJTaQ1Pxp5mZB2G9+foUV/rnagplbsqJFZC/ep/j3dCyXF2QSxt+RirYFeaQKQnSuVWddusiZyWU3v3J3gUJM487ZQdVO9Nx7EsyjSRTzNgSBJz93V6R8XCyQlE6s0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545918; c=relaxed/simple;
	bh=OBvw1xaU/uaECzu9DtzI0ayeZxwt6yRRTIuFeQaME/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtsPAVhcOakz/yCIkum4he7RcnoggAJ/T7yjZIeyNK2I8tIxP1fXKyu273dyoXFJdZ82NeyqTtFPHQSpGUvP1PeJv+qrSs9i7v62cSkRoGfP1O+Abx2wXye6lAgT2DYDpUO7roQb/GzJ49C/A3ugY98P6MIqoFUBT7vYCWYeKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikrdPgnr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723545916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNmAUQqPRhlKyJzPZ4t2TEAUMGFO9HvOUN+BVuraMug=;
	b=ikrdPgnr6TRPEmXDOhJu4bvT0G9tDg/yAXDBb4tEet/C9jABWoTioorWLIbDn9huC5T1VR
	nN/42xtFXN0LkGWtySJTCLO/6sGyAS+tC4X83XPJ6fNL4OxFJPwobhqxB24D/kMBh3M3Yc
	NJUUN7BIdzQXSrwC2d8c2v8IcB00JN0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-1d8AC7I7Mn6H56PXyAMXQg-1; Tue, 13 Aug 2024 06:45:14 -0400
X-MC-Unique: 1d8AC7I7Mn6H56PXyAMXQg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a80c12dede1so365542266b.0
        for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2024 03:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723545913; x=1724150713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNmAUQqPRhlKyJzPZ4t2TEAUMGFO9HvOUN+BVuraMug=;
        b=DcSjK0R6RP1puDR+DeY2rpWCuxH6B9UDsIy3/sTC8o+/EZ3QtRuut6+VkgL/ZdTWMH
         DbS24KapEC6NQiC5kE0yaBeohr5fP/OgIsOK+KNpFcj/le9soq1r6AtA82UJg//svAVd
         kq4drwWA6L+oHnKusXeaW9+WAlF39WdCIK4HxzxDQz6CNBtvIR65RtRBwbqqVlNwS1R/
         QLkLt0oNtWfefMZgx7KEKEoqks+nOy6LbjUiol2lMLvwD7AImXbnMIEFFwFtEdpIR18n
         HXlIZkRK2tqY1beunJTHayiGE6i1Wp9WVBTFYO25YpG6uLJECji2POKieVm215Sdcoff
         f1NA==
X-Gm-Message-State: AOJu0Yx187QLkS3kFLE4djeHicc6sBT5TM+r4h2pfQr6AS8jZgZXaF47
	4XFivtoC+8GIYxkHJMlcKMUWoqUndwkVhDgDrX0qmAANCBz7gqu9qpEXiGY1ZzOc0pzmZK3pO63
	CR9FavB3pnMMxgbvelYDaCTOP92f3LWD2B7rqW3/CMvGktuY6TQGDHXNRU+CKqC/EYig=
X-Received: by 2002:a17:907:7f8c:b0:a77:cdae:6a59 with SMTP id a640c23a62f3a-a80f0c1c0ecmr204697666b.21.1723545913322;
        Tue, 13 Aug 2024 03:45:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg3y/swaARDzsXVvBVaNqZCETbPKUlsdwQytOh/1DnlkwkGT0FqiFSr9vqAKpmsmiVUt6FIQ==
X-Received: by 2002:a17:907:7f8c:b0:a77:cdae:6a59 with SMTP id a640c23a62f3a-a80f0c1c0ecmr204695766b.21.1723545912738;
        Tue, 13 Aug 2024 03:45:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f4981dsm60266666b.18.2024.08.13.03.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 03:45:12 -0700 (PDT)
Message-ID: <0e6faf83-d8aa-48aa-a49a-ec28b0d56e8e@redhat.com>
Date: Tue, 13 Aug 2024 12:45:11 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
 <c0e5414a-ec7b-44e3-980c-e71889150767@redhat.com>
 <0abc1a17-e155-4587-ada9-13f9ce5f358b@redhat.com>
 <1a426f61-1454-4a77-8262-612ab1d0d265@redhat.com>
 <CAJZ5v0iWy6oXRJ2mxhOLyWsmgp1akVjoo0i2pqDDMOg-TvWLPA@mail.gmail.com>
 <a0f54ea3-5830-4420-b4e7-73ea8c146bcd@redhat.com>
 <d7ea226a-24b1-42e9-80d7-039729d93d34@redhat.com>
 <CAJZ5v0ivbV0h+gmpL+LCUfdDmExjJ1G60jQTzf76iWy6aT0e-Q@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0ivbV0h+gmpL+LCUfdDmExjJ1G60jQTzf76iWy6aT0e-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 8/13/24 12:40 PM, Rafael J. Wysocki wrote:
> Hi,
> 
> On Tue, Aug 13, 2024 at 10:46 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
> 
> [cut]
> 
>>
>> The reporter of 2302253 has reported that the patches from:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=acpi-ec-fixes
>>
>> resolve the issue; and as mentioned before the reporter of 2298938
>> is not responsive atm. So I believe that with it confirmed that this
>> at least fixes the issues on the LG Gram laptops (1) these patches are
>> ready to be merged now.
> 
> Thanks for the information!
> 
> I'll go ahead and put them into linux-next.

Great. Question is the intention for these to go to Linus
in the 6.12 cycle, or do you just want to let them bake
a bit in linux-next and then plan to send them as a fix
for the 6.11 cycle ?

The reason I'm asking is because the patches these replace
cause a regression on some laptops models starting with 6.9.7
and also all 6.10.y kernels (and if you wait till 6.12,
also all 6.11.y) kernels.

So although this is a somewhat bigger change my personal
preference would be for these to get send out as fixes
and backported to kernels >= 6.9 (1).

Regards,

Hans



1) Just like how the patches they replace end up getting
backported to 6.9.7



> 
>> 1) And based on dmesg with a regressed kernel likely / hopefully also
>> the issue from RH bugzilla 2298938.
>>
> 


