Return-Path: <linux-acpi+bounces-6670-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44BE91C4CF
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 19:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015EF1C22EC1
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CC51CB339;
	Fri, 28 Jun 2024 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETorOl2e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FF81C6899;
	Fri, 28 Jun 2024 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595631; cv=none; b=Yg0QgqlCnqnE9Vkodfx8Kgkcb0Vi8rToJtwMlVhw0gxfvTbTu+1T7EL/5RYjZeKTLcg8mCzRrOorJq1f+SdAQ93m+0W4CBSLGjD3cGslp7JPwLCNGX2HsBpjfJQs/wJYHGWjCCc/JHViH91qUZvbC5icwZvyvZQGARoi1SJe9dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595631; c=relaxed/simple;
	bh=Pl4fx3mvrC8/402KEMfdyFxzgN4b2vpnlOw2DUaW5DA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0JpjE/n1qa3O4KHawU1arL6UYQ8Pcxnf56bKE97wW+NESpKC9z+kMpR1kFFVmDHm5oN1DF5ocDCzb4Uhrn5K9aS2TCNEortFa9/uxFIptC6JDIKzdIM1ssdjyAPQ1UM2FHnN/TeSRp2Hbreu7Oy0zoQTVxaRvD9OszyIxTtasw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETorOl2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68480C2BD10;
	Fri, 28 Jun 2024 17:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719595631;
	bh=Pl4fx3mvrC8/402KEMfdyFxzgN4b2vpnlOw2DUaW5DA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ETorOl2eupSSPftAGmIP9VZ69J20eRXYr4GZWeYjotdBvXRYpdPyYFnja92PuCzek
	 gKlFI69Yz4OffhjcwJpzuQGuhLUwWfTHbIvuH4FDEU+1I605KvLXV+0TrVjx6BS+Wd
	 aKVvR4aE5J/YbJKQCl17TtSfXImqbA8TM6rCvv5CPVVWgPWDqiS//AVBKroiui8pAk
	 G0baifVUeoNdUiU1K5iP1KUerKIDNZUdJP2jR9C35QMNaX+7Ibzx7YgnWMAT2B1p9R
	 MCgIAfjRY+DUQvVVNGGiXa82Y9+tV9Gg0ssuHU+qJvrPJth2/qUD9KaU5pYxzzMsNt
	 ix5xfcxBir2Zg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25ce35c52e7so121077fac.2;
        Fri, 28 Jun 2024 10:27:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9/KRFoHSX3enBLwLFERu/ZnIE2x9XTJLeixqmaqkzKs9jxSNvVEwx9+DW83J2moloAsC0zda4KcEvBH8eBhsfG4wiODllPvUFhsXZPHaPoS8FCI+O9V4Qq0Bixy4sHi/d5YPmqxkgnQ==
X-Gm-Message-State: AOJu0Yys0YpLHldMpYisUmvX/z8EbJMYSKjHXZeRhgrvdoNcKUNfBu1h
	GSv1i91JLBhyBy114HrkcVWJhlf+H3duOfbg22dOc3/GnpZWW0qRJ50Kd8R4gcZSFwm7jxpkU9+
	+gC8HbiGvI293d132qTj+iTyttVA=
X-Google-Smtp-Source: AGHT+IFDSFlkBcA1UtUiyWxUVT0UTQuwjc1IEII89TUuy5oCwtaa5V2sEhUNiihyJ9+lo7439NmQBVZqeSON5l1J/T8=
X-Received: by 2002:a05:6870:8a24:b0:254:cae6:a812 with SMTP id
 586e51a60fabf-25cf3f17d37mr20750734fac.3.1719595630627; Fri, 28 Jun 2024
 10:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
 <20240613-acpi-sysfs-groups-v1-2-665e0deb052a@weissschuh.net>
 <a72495c3-c996-4be7-bc64-ba10d5400971@sirena.org.uk> <111f7a2c-403b-40b3-9e25-8c4a040d8dfb@t-8ch.de>
 <d599e864-9961-44e3-8b9b-bc41a8044319@sirena.org.uk> <4cd2352c-4e95-4ddf-a366-75dad45bf7e6@t-8ch.de>
In-Reply-To: <4cd2352c-4e95-4ddf-a366-75dad45bf7e6@t-8ch.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Jun 2024 19:26:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hMbd_y5P0mvVktSEesYs5hGjGaFpqm3KuHqzgT2diy3g@mail.gmail.com>
Message-ID: <CAJZ5v0hMbd_y5P0mvVktSEesYs5hGjGaFpqm3KuHqzgT2diy3g@mail.gmail.com>
Subject: Re: [PATCH 2/5] ACPI: sysfs: use device lifecycle for _STR result
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Aishwarya.TCV@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 7:17=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> Rafael:
>
> Would you mind backing this series out for now?
> I'll do some more experiments and resubmit.

Done, thank you!

