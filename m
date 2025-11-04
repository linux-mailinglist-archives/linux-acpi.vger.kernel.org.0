Return-Path: <linux-acpi+bounces-18481-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A341C301A8
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 09:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B978334EA04
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Nov 2025 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F0127510B;
	Tue,  4 Nov 2025 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HbfhUsNx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE5026ED5F
	for <linux-acpi@vger.kernel.org>; Tue,  4 Nov 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246699; cv=none; b=bOKK1pYqleXimNcz8XPqfa9KxGKZL2tEzw50miZC9aELFPeYeCY1GnT7j9qvLs+vi3fbjaTLv2q5Z4/xheaMCRk8pA2aqz7yyt4U2wFPrMIZTYcaC1J1YGEc0F+hAtu/KzC7AceHYTGnmUTvhjhoAPpOnaIzoOLVGtZ5Ce+CvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246699; c=relaxed/simple;
	bh=buj/u/JwTsK5y0POmxcq1Ius3CNuM9gtzbALUFSrW8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIJ6pTWTxV8l8bOxB0ALl/k/0FWtvmATmRDFn+Da6tzNAjPNHZDT8SKmL/iSDVEd2lr3e6MYnnMlCzEkJbfYV7iZ5+idHPttd4XtjDc+wcSmKgQh95DiKiyoZradgEOsVMhzcEWesOojOR+pSpf6tEtnJ9C2ZBc/wFq1Udu140s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HbfhUsNx; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5941567218eso5408767e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 04 Nov 2025 00:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762246695; x=1762851495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buj/u/JwTsK5y0POmxcq1Ius3CNuM9gtzbALUFSrW8c=;
        b=HbfhUsNx7WiPmSs50B/3UQusuoWhnbFg1ZMUimQS7BJukDSHFOx2cHxYd352dPmkWN
         NYnFMAb8Nktqb88EtycgByVZJXBrPGunT+qGggwRwx8S18+93NIh+/+IJgyItKAMELXA
         pswDEdMmwZ6Kj21fKIB6OFxDLWJ+h4BOesF75k5cglY6XSTxo83Wpbwz98IZdLILz1u/
         CWVzghb7YJSfZWg2VXZKZZ9Mzosa+3HbekaBcc0PsYASXLbr9iO3O6WrX2hN8WolemMe
         /KJWyus7iro7QE+/5hHS/+KDb7ief1vArrpX7ID7/DpFvM3qt4r3tIsfwxWbRiWiiFE3
         mIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246695; x=1762851495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buj/u/JwTsK5y0POmxcq1Ius3CNuM9gtzbALUFSrW8c=;
        b=t6SQuuw4sbgiBSdxcBReRM7fxcjqDM8+NTl1Ndn6CMK5XYKsNTDigwj2PHBK4/AZ85
         Nt7hn5U1cM4BjH2KVW5jvEDy7z1RMWzgBF2HVruFUJ6VsGb/5azUNC7h0fXMfam8gZ6c
         PXGcQU8uOWRVs2C7uHAWaSvqXwhfJFPMMXqsxobw0sHpDDydexm/0/xQC5b1PUV/ZENx
         su0aUqa0Hm4YnmwyYjwokWsa1j11T48i8Cy67unkee8psfYKqVZYgdrsiqxicNU7SvLM
         asFCWZ+7iNyGgFwrRCFGAoJRVCqx6oo6zwEGpo46bHDUScZW3D06FWKaKHayv8rhTvAC
         cd9g==
X-Forwarded-Encrypted: i=1; AJvYcCWpzYRQZLIyclAf/O5ZynchgWUx4ogOOLC1hIvrqvA3CW8WfVhtfvgqRpzWO7SiWFkjn1HUmbYM82ni@vger.kernel.org
X-Gm-Message-State: AOJu0YxbzNsY6Jk+oehO46jP2bToJ1GqJZT9ClucdW/AQVS9x8+NbTYl
	qIdHvKU9z44nH13uORDTf3D18ngzRgCjmGkllsBdZUyfFKM/d86gnYyVsGzZPzxmj5zkejZ9xa3
	Vsm70rM5k/qycEErYt29M51DlMFnBaHUXNjyQjBr9lw==
X-Gm-Gg: ASbGncvAvRIodrALjniK3Crg797lkvRiqmVzqsEGagN+uLuAE2LAHIaxk3Qo88IJl+4
	auTd/7Mr9Rh+XUkWr3qsxbmR8kJxFEMRCMzdpHWB6Ufye+7KjoSfj+hBy7EShD3wu5gapKSbrVV
	ZVuJsfHNAPlyPaTVZcxl3KT2LSO2m4zTDbhP9ziuTIGkxXJvH49BAvy5ls6IXUyJaH5rmLMvK3Z
	yAHzGUNG4OvcIXnWNTS8iA1DO0Fvf9W7lXxrckvivUKVJXSuhMpNVgGcq5kKe54orRNdd430Zq9
	IIxiXeAbOevI+Ee4og==
X-Google-Smtp-Source: AGHT+IHzS8Tb36mlQDGSAgmbKE6QuvjHT2fmPiFvH3mcNUc3pQA3uN0hwqn5NtJVSNk2qDHMPfgxHaf6Ti5/HemNdSE=
X-Received: by 2002:a05:6512:3c92:b0:58a:fa11:b7a1 with SMTP id
 2adb3069b0e04-5941d519925mr4899489e87.24.1762246695081; Tue, 04 Nov 2025
 00:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030154739.262582-1-marco.crivellari@suse.com> <CAJZ5v0gV_6+3WC6eLe3nGagx+NbmqsOFtDGFnBhyrU=H+_=+dQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gV_6+3WC6eLe3nGagx+NbmqsOFtDGFnBhyrU=H+_=+dQ@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 4 Nov 2025 09:58:02 +0100
X-Gm-Features: AWmQ_bluACc7VGij-_FS6w5WYAmOVq2OjWaCef_HeyFB6IM-t2ntxrOoT6rTSWI
Message-ID: <CAAofZF52vvsH8CS-Bp+q8vFoRWW5jeEsENgtMHBetZMgNinkPQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] replace old wq(s), added WQ_PERCPU to alloc_workqueue
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 6:47=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>[...]
> All applied as 6.19 material with minor tweaks in some subjects.
>
> Thanks!

Many thanks Rafael!


--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

