Return-Path: <linux-acpi+bounces-18015-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973E4BF3513
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 22:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545AA3A7FDA
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 20:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4CC2D3A7C;
	Mon, 20 Oct 2025 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILXTBSTO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490BE27815E
	for <linux-acpi@vger.kernel.org>; Mon, 20 Oct 2025 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990628; cv=none; b=LjcUG6GNawN+oc7Aq+oivX5TeOdzPwEuySXEn4Oz3NbztEornG8qOyN6Sjoyt//l1fVUV2SAGBHAs31oJbzjXoNsSjnhV0g0SSH+kMkdMlYZPfoTGywSLE74vozpLEdCUf+ZpwqmCy/hVo8NK1F3PXsdSu4OZVDlnhnIoMIxdBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990628; c=relaxed/simple;
	bh=0GozyBfFE/XRk5cEtiFPVwldSEqU/T8TD1K2EzuejB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unlhGa7O0R+R85V9s0y038aJypqv0PyWs7MIScDM52jDObuHE11ALSqnT6yh+4uac51srkcgx1F90LhpFT/KN10n4IXqCbs0wap149zi0Ny9xZlzxv5M8kVBK+PSmt7iAgtzX2avbnBELggtQRhqaAg4mxhz2jqS2Rv/rR82ZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILXTBSTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD652C19421
	for <linux-acpi@vger.kernel.org>; Mon, 20 Oct 2025 20:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760990627;
	bh=0GozyBfFE/XRk5cEtiFPVwldSEqU/T8TD1K2EzuejB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ILXTBSTOXkJK3USTjKaZ9KFevI95mqyFc+W8tzFp6ulexdr7+pCvaBBAiA48+x8oZ
	 92lFEDEIIkLeYLGeWa20nweE9t1GIFVjZpePnkrQZGe4tFIFJtSmlIAVMnDz0zLU3e
	 crpqp4jN4pOYXvsuPHP2STVxPpmpNqH2KCNcyCEtOmObiFxafzKbYDCq86fWmRjBhB
	 ikSakG3MdLkX4sx6wkcvCHt2C4KWVSNIh8kfWpES7GyZE2RHKYcCeVYz6g040lvJTG
	 fNZVVYiMbEe+JAcY+J+2QCF6ICSJPGx2RxJ4NjoG9zJPT57qRbM9P1PV0ENLhi1eIO
	 P/yPmc+7uboMQ==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4439f1df5f6so1138908b6e.0
        for <linux-acpi@vger.kernel.org>; Mon, 20 Oct 2025 13:03:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YxlpEBKZwBKf+dMLQNYFCX2fzkFveyhvPVGOoU+Hs9f02YcC/AQ
	bCORT/GiG4A1n9ybxV0s5qxmmTrmxBGiIY7bpH+bQtKm/nI5VrXlCO2zt7CBc02WQBs2dP/sQIF
	BOxN/NjCVSzpGrKgam8syvkAVC5D+F0k=
X-Google-Smtp-Source: AGHT+IEfVQKQoOS1LKrE3OxpSCSieumL5MB9CZHdCoKxuiJ6J311Wi+yzh6LmN1tMKVjC7xE88iyCubE1opB781uoV0=
X-Received: by 2002:a05:6808:448d:b0:443:9ec9:8fed with SMTP id
 5614622812f47-443a309b073mr6829331b6e.66.1760990627237; Mon, 20 Oct 2025
 13:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017100744.71871-1-sunilvl@ventanamicro.com> <aPPsmKRcB9YKYNGB@ashevche-desk.local>
In-Reply-To: <aPPsmKRcB9YKYNGB@ashevche-desk.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 22:03:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZmA03iNJQtiFHmrvrZwqbBYs285600nJYoqtjmXVONA@mail.gmail.com>
X-Gm-Features: AS18NWBsG9jhRBi5AxAtMxnTpSD3Otd2HrxrFJwkP0HzAntSNa4a9LATbyA3gtY
Message-ID: <CAJZ5v0iZmA03iNJQtiFHmrvrZwqbBYs285600nJYoqtjmXVONA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: property: Fix argument order in __acpi_node_get_property_reference()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Paul Walmsley <pjw@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Anup Patel <apatel@ventanamicro.com>, Thomas Richard <thomas.richard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 9:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 17, 2025 at 03:37:44PM +0530, Sunil V L wrote:
> > A refactoring bug introduced an argument order mistake in the call to
> > acpi_fwnode_get_reference_args() from __acpi_node_get_property_referenc=
e().
> > This caused incorrect behavior when resolving ACPI property references.
> >
> > Fix the issue by correcting the argument order.
>
> Thanks for a fix which looks good to me,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied as 6.18-rc material, thanks!

