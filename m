Return-Path: <linux-acpi+bounces-7906-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9589618A2
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 22:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA96E1C234F8
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 20:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BDD185B77;
	Tue, 27 Aug 2024 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTpfk9sT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB1537F5
	for <linux-acpi@vger.kernel.org>; Tue, 27 Aug 2024 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791249; cv=none; b=b7Vkglyp1rg/wu3AQBKCDBBZQoo2aE9T1kmvCQlM0L01dZorN3o9CbcmNYgBLRjP9smQ4DrYVLCdvEXGZ2NOkJRK98ZzJlaCo44dhau2UnKWkOA+TP7LOjJn0hQgNWhOH33/CrczbTBR82SVS2Ti90rbqho1wHtEWJGbyZCll2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791249; c=relaxed/simple;
	bh=xmBYTg+6ZwnT9hfAgbarpSCBsjxKw785Do4JxLfL7c4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=n8qL0K1W5+pA3cRyDHkbQznyF+bFva1fA/9XYjSaEgDALxCKome0IL64ahmJTrouxQPxzY+hFv5B7NPIoMz12+XAvsp8j8JvAAEhCHKYMXOUTt+0ORvUDav2PHViqvhIJo5ywQNeLXhCJvJeOADrQWyBE5fhYkEaPlEbsD5AjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTpfk9sT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71446767885so430021b3a.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Aug 2024 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724791247; x=1725396047; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ruXfsY/DRqP7G7TuTXo05oFFghbiT2PiLz+d8ewe1g=;
        b=DTpfk9sT3cZT45hETtpUVYJi6swDdlrhstczPHK3866ivfj3P4KfyelHh1zcE9H9zE
         /hblAGhRS4wW3iMMLMVjxqnb5worBQ6o0u0/Z35oGV65h14S5ZgggFZBZq5Y7SM7ibFT
         44jJY+kLhBjUCuuOE4KB/mUVhQ0ytaORhicfsUxvpydCNlo5bcObK+q4BJy8Hk56bR3N
         cpUMBWjPxLHyX0EI0mabGrq3nf3gJkZfCrCZ8Q9MDKBBl2iEuKl4c/FckpQrqKeEusHq
         RR+uFeiec/BAwNl9qMR5QGvdRhYhKIkH9m4uQUrac6R3Q/jUYViaFPFtc1dNYjbsdS3D
         f7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791247; x=1725396047;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ruXfsY/DRqP7G7TuTXo05oFFghbiT2PiLz+d8ewe1g=;
        b=dPLkGL4EvdWIphPQzT2PJf3gK3jXNJx+8Sed3wcIAezU2xG0DoAJuAFD/q/FTbYUI5
         GAXKB9cic0xxKK5iKhD8dEucaIXePJLiVYwBAq32BvE/3fCTC+Fbx/U6DgKzcJBnukbO
         TUpY1Sf9HAPT9iTsXe/i2PJnwPQqDmMojLMR3WQ6fauDEoPOuLwUaIDOTen+MZo5+T+W
         3TexbXdsQsZ8e7DjCLj3Re9RUoAV3tY7Qoz72L164bTECC6hIPTHWDPXZV5pW9ePbhTz
         CmqC6KTGwOUj7+wdV8Ro215N/6HFUKhsFjgkxzJeo6W68r4hdL6huBbn+LVk0vfzn4ur
         lSjg==
X-Gm-Message-State: AOJu0YwUi7mC/c90cVBuJbuwke2IJvaWxTuWsNypPKUfrb2hhjX6qM3A
	NabWehsptF/+FlUcRl/vx9+G8mt6VNlYYTOEApLdfyc/OMg8lS3B
X-Google-Smtp-Source: AGHT+IFrk4+yKAQfCIOTy8YmJLF3vRaIDkwOMDAZZxw5lN/DyH5pVgxRx7XQFoc2sSNZIsm1aFHc7w==
X-Received: by 2002:a17:902:c40d:b0:1fc:6d15:478e with SMTP id d9443c01a7336-2039e46dc69mr103810425ad.1.1724791246813;
        Tue, 27 Aug 2024 13:40:46 -0700 (PDT)
Received: from smtpclient.apple (va133-130-115-230-f.a04e.g.tyo1.static.cnode.io. [2400:8500:1301:747:a133:130:115:230f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbd9b0asm14891173a91.50.2024.08.27.13.40.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2024 13:40:46 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v3] ACPI: introduce acpi_arch_init
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <64bd9991-61a9-5cb5-60fe-941cb4171290@huawei.com>
Date: Wed, 28 Aug 2024 04:40:29 +0800
Cc: linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4EC8AF0D-321F-437B-93C6-E597E4D4BB34@gmail.com>
References: <20240808-intro-acpi-arch-init-v3-1-ba510859baff@gmail.com>
 <64bd9991-61a9-5cb5-60fe-941cb4171290@huawei.com>
To: Hanjun Guo <guohanjun@huawei.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Sudeep Holla <sudeep.holla@arm.com>
X-Mailer: Apple Mail (2.3776.700.51)



> 2024=E5=B9=B48=E6=9C=888=E6=97=A5 17:43=EF=BC=8CHanjun Guo =
<guohanjun@huawei.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 2024/8/8 17:00, Miao Wang via B4 Relay wrote:
>> From: Miao Wang <shankerwangmiao@gmail.com>
>> To avoid arch-specific code in general ACPI initialization flow,
>> we introduce a weak symbol acpi_arch_init. Currently, arm64 can
>> utillize this to insert its specific flow. In the future,
>> other architectures can also have chance to define their own
>> arch-specific acpi initialization process if necessary.
>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>> Changes from v1
>> - Change acpi_arch_init from a static inline stub to a weak function
>>   according to Haijun Guo's advice
>> ---
>> Changes from v2:
>> - Add __init attribute to the weak acpi_arch_init stub
>> - Link to v2: =
https://lore.kernel.org/r/20240807-intro-acpi-arch-init-v2-1-9231e23a7721@=
gmail.com
>=20
> Thanks for the quick update,
>=20
> Acked-by: Hanjun Guo <guohanjun@huawei.com>

Hi, all. I wonder whether this patch is good to be applied or
any improvement is needed.

Cheers,

Miao Wang

>=20
> Thanks
> Hanjun



