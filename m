Return-Path: <linux-acpi+bounces-10804-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F603A1AA64
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 20:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFA0169E89
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7E51ADC77;
	Thu, 23 Jan 2025 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXjFcR2o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6B1ADC6A;
	Thu, 23 Jan 2025 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660964; cv=none; b=U7Dq3Rd64K68pAaJg0rxBD6I+vQCiQJ1J0d+zlJSOZVqka0eQFzxxgdZupblKsIhXE6fkWekka79VIDIdpcrwuG0tsWErc11GgN2LkxqUYIfi+PPw3jQxiEpr5qVFkB1AA25MEqem3YzrEKKaGNQeKTo4/g8aXgZjdkXimsoSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660964; c=relaxed/simple;
	bh=fUrjWZrN9ohdmp0phAAf1FFtrLvoGfg7dfSPFz+FpHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrY+u4TqYNGFxeLGIr/fYjBiWK50NDKFhheHU0cSKcjE4WQ3EGObExD0HHhQ/g7GvhvDTxzHPyKXXydhRW8woi4MRgE5O48QP63fXKP44bdSyEGnDRBDJshVcNqeFtzBb9v9xVcR48atripNvKX2aJ44qnP3KZTANnBtVb8v8Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXjFcR2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A9AC4CEDF;
	Thu, 23 Jan 2025 19:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737660963;
	bh=fUrjWZrN9ohdmp0phAAf1FFtrLvoGfg7dfSPFz+FpHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uXjFcR2ovIDTOHq6Bxgy9eN883F8pokn9mX5ggqv7RzrXMiOX6ua4Q69iGo27r8s4
	 5kH7A9RFYcPkSULGZKUspY1eNQ7J83TfFc6d6+T3x1XDSTqH4xw3IGxWHU1qg+OJXP
	 ar322SGDB+fjm6DV0eFsXSi+w4ss9214UO8oe5xoMWdEmDvtCX4lou3IqUOANz6XPE
	 WW/lcT+pKzYG0/D4bvpun+r9l8gY52wAKPhDy8G4hz23nhrBfQBtiGAnE1MQmRG0wX
	 +xN27jb5mI2cbuGtgRKB8+TgPIUFLCsHVjujmtEA1w4asDpAmVNxgfh20Bf8X0qnGc
	 MCWHgeKVCM8WA==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3eb7ca55c3bso699820b6e.3;
        Thu, 23 Jan 2025 11:36:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUg+1yHbDOuApBM5iFIg/TFza8+p4h2jfGHD+nN48Ovbet0QXcelc+bX4GKPmZHhml/YsDPbAbWLWoodxzN@vger.kernel.org, AJvYcCW6Uh21qWVZGpC5xXqe8kNLYbihgxQgX2yA6pJaytWYtgpyGOXIlBa3WekZN3U3EzTl7EC4/UWb/Tyg@vger.kernel.org
X-Gm-Message-State: AOJu0YzWPubBOkUtJOhNQUfN2AxNacTYXjwmBQotrv+abvckXMHbnYzP
	pjH+44BECYEJx2MQy+w8omNtEyeh8IEAd2ctCFec5tK+aLGuG7qMJdCHdC0/DoOjcfI3Y98Z34O
	3+J4ZV9dV15+N7Ut9he1J39TN5qg=
X-Google-Smtp-Source: AGHT+IFSl2Bar6iiwbLK2Fc8x29rkTWOhARyh1Ug0IZIGQmzREIzYAcMLKHgfkleW+8CyXwbIs0VJFGYL5DAkIwfiJ4=
X-Received: by 2002:a05:6808:3383:b0:3eb:5afc:80da with SMTP id
 5614622812f47-3f19fca053bmr17492272b6e.17.1737660962912; Thu, 23 Jan 2025
 11:36:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117022957.25227-1-tanxiaofei@huawei.com> <20250120110417.00000a57@huawei.com>
 <58a450bb-55d1-5415-4b67-9d61603ce48e@huawei.com>
In-Reply-To: <58a450bb-55d1-5415-4b67-9d61603ce48e@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Jan 2025 20:35:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ihVJBX0bLqrL-61=LKVoZJOg3RpJykp80uOMf_7YcG+A@mail.gmail.com>
X-Gm-Features: AWEUYZkqeZY8g7c2ZVg2ZJLRxZ8CGfnhaUq1VPGOWIYZ29PUcYcpD6S2DSmFKUM
Message-ID: <CAJZ5v0ihVJBX0bLqrL-61=LKVoZJOg3RpJykp80uOMf_7YcG+A@mail.gmail.com>
Subject: Re: [PATCH v3] acpi: Fix HED module initialization order when it is built-in
To: Xiaofei Tan <tanxiaofei@huawei.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mchehab+huawei@kernel.org, roberto.sassu@huawei.com, shiju.jose@huawei.com, 
	prime.zeng@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 3:23=E2=80=AFAM Xiaofei Tan <tanxiaofei@huawei.com>=
 wrote:
>
>
> =E5=9C=A8 2025/1/20 19:04, Jonathan Cameron =E5=86=99=E9=81=93:
> > On Fri, 17 Jan 2025 10:29:57 +0800
> > Xiaofei Tan <tanxiaofei@huawei.com> wrote:
> >
> >> When the module HED is built-in, the module HED init is behind EVGED
> >> as the driver are in the same initcall level, then the order is determ=
ined
> >> by Makefile order. That order violates expectations. Because RAS recor=
ds
> >> can't be handled in the special time window that EVGED has initialized
> >> while HED not.
> >>
> >> If the number of such RAS records is more than the APEI HEST error sou=
rce
> >> number, the HEST resources could be occupied all, and then could affec=
t
> >> subsequent RAS error reporting.
> >>
> >> Change the initcall level of HED to subsys_init to fix the issue. If b=
uild
> >> HED as a module, the problem remains. To solve this problem completely=
,
> >> change the ACPI_HED from tristate to bool.
> >>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Given the change in approach (even though I reviewed this internally)
> > should probably have dropped my RB.   Anyhow, consider this me
> > giving it again on list.
> OK. thanks.

Applied as 6.14-rc material with a rewritten changelog and under a new
subject: "ACPI: HED: Always initialize before evged".

Thanks!

