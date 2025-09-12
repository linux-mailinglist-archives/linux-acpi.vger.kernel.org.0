Return-Path: <linux-acpi+bounces-16789-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A91DB5582F
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 23:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB603B2EC4
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 21:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1951338F3D;
	Fri, 12 Sep 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQIJIIev"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B333472D
	for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2025 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711597; cv=none; b=cf7mTlo8Z0rOalp5d6Ddmfv0abrFZyl89X23ooihtFSK5YUp83eMxWrJoJ3/AK6oJdlMUxOnxPIEBRonl+bfLS22zzwgk91oCi02EaQU36KTu6HuOcYmDJLdPlQxmLwd8BXUYy5OAtNcBN2JP2OlmvI15eAJUIjqxgzwxo/U6tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711597; c=relaxed/simple;
	bh=gcaCtOTSXV2XbJKiE3q73MLyt7PVw58fJiPF6uaIJog=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cczb1Ub2NYFq7ujuERAZhfIJdibSPmCcDN/ePI7Z10KalLuWa0rDKqYqHqid0hjjXikQCTxey32yhywfV+9uQYL4igiTOt3xTDKN4YZIyQYkeSjEljTPjzGGxdGSkIDd0xFP7gl4jyE6de92HWD/kkl/e0sawibOmLYpEjlpVEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQIJIIev; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757711594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
	b=bQIJIIev9FH0OQQ421DUh/0BJ8orzHzsXd6pcMjRXR1j7ViIh9czwS30v5cm72rRlCqpt/
	8XBZSmML71+QFP2gWayrtQck8q7YDV/vZkpfeVDZiBVyua4Oa7r/WNoTfQUvWcxOadWxPO
	YVJ2EenRJzss4EipZQ++j2ah5uSHqcY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-nuGQJ5SZM9m6lZkW3xqxQQ-1; Fri, 12 Sep 2025 17:13:12 -0400
X-MC-Unique: nuGQJ5SZM9m6lZkW3xqxQQ-1
X-Mimecast-MFC-AGG-ID: nuGQJ5SZM9m6lZkW3xqxQQ_1757711592
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b345aff439so68471731cf.0
        for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757711592; x=1758316392;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
        b=eaPUod2ey12hVheMJ5IujOEjXncsIfXo5t0P7lp1Xpu8WHiTfLUnlVoSfmswqSQel+
         m65c2DmUG4cW//MMF6tzgwNWOE3UpjZoSYPk/ECh0RUoJ7yKvHN81SAUDvg9TWNNgHXQ
         351vJI7BEcXBLsACa6B+3oQR5CHFssQEyRQrMCdcAab9F92UwOTAqgtYpRFrQZ5SXQj6
         ad5O3BLHeKhLVQF1rAbNZxV3WGhpYOV28olfq91nf8EEmDn9dk3dZscsrvyO2ckj1eyK
         6ChnRGCPMurtloG1TGegjRxQgnosjA2vy3M+7N9Jx7sisCzptcvEXtGrJeFt7LTB6jeF
         Fekg==
X-Forwarded-Encrypted: i=1; AJvYcCX80UqYRu87EfHdw0Ve3uczl5eA7XbYBdDQYyH7WvN3knos+ANLaeqN5uMtylXn8B4mrNhKc7NlZvjd@vger.kernel.org
X-Gm-Message-State: AOJu0YyeVXSy/rNeCpB0UcjSITipaVdxGNU3i3gsysrzs2PMDFqQBJlu
	1LlGPyNsS1EfI44YXr25UjHxOBbKPObsv6qm43N4ksDfqcKpMACTbQb9jz6pbdLeGnpdhosbWWJ
	YriIbUaQXKmHqIxUALm7TagQZx30p1WgeyX2GPKOxdGl6zpbNC8XbQrZfomq3lVY=
X-Gm-Gg: ASbGncuXLuhGbJcCQApXSzU5p5ejceaDxjDwsPtVWE1SuyEmSitJhW8HcSxspM+3zBt
	EEefg0svWBNMnTUH4I6keEsMcDJgaFmntRZ3YEda3ohTLyV698rbSgq3bBqUQ9s5VaYUktCvX1x
	UC0b3TiCp1TU4D+6qTLOsRly/pB2x9YAuVHeyfZDvPMHwBNZkYCR70SRSqf8oP5LU7ySGp6/vMs
	b15Ng5zL/rC+IZXKBVlbnOLc1YoZePmspH3dXYSVSTWmHIRKYZIBiDeyETeTlE4Xsh9Tyjg0H0r
	C9ZKDM4nF6EtAepbH6NWNwwvZKZBiG8oYDDBBtXucLMrGzxakqasmOobnj9g4rba3IvaOei1kmY
	Kjg9Qd+eRSQ==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549641cf.25.1757711592229;
        Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMw9fpUjKztDhFj7vngF7IcasgotLQXC7Sz/FG+fDJqIxlNqO5vbKN00AADMBFHKIX07xTcQ==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549191cf.25.1757711591843;
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dab102sm29277371cf.33.2025.09.12.14.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
Date: Fri, 12 Sep 2025 17:13:09 -0400
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org
Cc: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
Content-Language: en-US
In-Reply-To: <20250912065050.460718-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 2:50 AM, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
> disable preemption, which provides RCU read-side protection. When
> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
> manage RCU read-side critical sections.

I have some doubt about your claim that disabling preemption provides 
RCU read-side protection. It is true for some flavors but probably not 
all. I do know that disabling interrupt will provide RCU read-side 
protection. So for spin_lock_irq*() calls, that is valid. I am not sure 
about spin_lock_bh(), maybe it applies there too. we need some RCU 
people to confirm.

When CONFIG_PREEMPT_RT is enabled, rt_spin_lock/unlock() will call 
rcu_read_lock/_unlock() internally. So eliminating explicit 
rcu_read_lock/unlock() in critical sections should be fine.

Cheers,
Longman


