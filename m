Return-Path: <linux-acpi+bounces-13390-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3522AA5416
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 20:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7344C5985
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 18:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8CA235063;
	Wed, 30 Apr 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0G3VxxN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F131E5B9C;
	Wed, 30 Apr 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038995; cv=none; b=pFyXAL0l65uV21O11uccVn9ydOUKmHUULsH0dq1ZQo4BtehlCX9m51J08Hh4Sd5cjNtoZIQtG0z+X8bNxNP0UyS45tqmCSLk6NDZRkGrAf97vDq31TG/8XMCoG/qLjv17z/IYTpgbM8zX9Q1pnNU6xRPfL93TJogxgp94DrAVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038995; c=relaxed/simple;
	bh=k2jZImIplLtrep9ZLm69IqQCo72lpoWaYbejGDF7KOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3iSEenwlE17br5P2i1QbPVGbKzg1xG/CwqF3YMR0aoj+SZ6wh1d/HEuJJRSUp/k4ao7Rt9wFW8eWSkCKKRF5mv2dlfqcG2X5r5DSCE378dyOI7c8RInd3xPcNbVhE2janIszFk/Mtm8RwS8vWfiWUIpMCAEG/sbJChSsAtWB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0G3VxxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775E9C4AF09;
	Wed, 30 Apr 2025 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746038995;
	bh=k2jZImIplLtrep9ZLm69IqQCo72lpoWaYbejGDF7KOQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N0G3VxxN/C4DBG/ztgKALICySfyN/lPMhnXRfgg481aZAd+FtYC01eQTQrmsZGbo4
	 AZcfYCFxQ674tvMIbdEMy1tFuCsVHGkK+aysCZqt74NO3yn8Sycfi8lyKHQkNvXAmj
	 kz5soKXbZMiT0WDhLelvlbu8jD0Wey5dpdyvX9QaHiBROLD1yYy/RUbQUpq6rivN+N
	 O4BqkBPSpMU8foNKBqrE4cfVZmWtmdEw/hafde2hRMi1Ig7GY9hEtxAdkBEWbAqP+c
	 MykKDCgJll7UaI/kRU+/Bp/Oe+umY7gN6yiyb7tTsLFsaacbDWHTR9ZkhccBTTZqGA
	 Seb9yRrbRHB4w==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2da3c572a0bso145015fac.3;
        Wed, 30 Apr 2025 11:49:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcWVwZ0FxdR61pSCoP0uJMZT5hzdRtS2Q5W8KBi+E5TMxYG6pelJ3Lq2wgamIDTiYtA/b20za9AuY0ODbS@vger.kernel.org, AJvYcCUpVG66rHfwmGnG7vVriBdTU6nu7kmnlr4wp9o4qpP9rYQKFQuAqsSxRUDtUIDAzJ8KT9VlAxdVYRDZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwoBlspwM45gXKD7Pk3FXHoIF3y5aut0KgaEfAXyGMUbVZ0wUut
	J+XJ6G2gy1GRBYUI7y86kixX+VB7m5nIyzAE/VVOEZPAzqudlvPOD8fGR2a1pH9Nol1tvI1ZPox
	TFaTi0IEVe+OyUFSObrX/LndbhEE=
X-Google-Smtp-Source: AGHT+IHCVfuzVWNY9nHwwlciHk6mqob+lxlgBdZjMWwwxzLNFTxBXSXIniXZZgevdbzCe9a+V+ySH2ltwONC2ikP5Os=
X-Received: by 2002:a05:6870:9624:b0:2cc:4516:afc6 with SMTP id
 586e51a60fabf-2da8c82fc61mr263957fac.36.1746038994790; Wed, 30 Apr 2025
 11:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12671029.O9o76ZdvQC@rjwysocki.net> <1841930.VLH7GnMWUR@rjwysocki.net>
 <202504301134.2EF987A@keescook>
In-Reply-To: <202504301134.2EF987A@keescook>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Apr 2025 20:49:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hsJr+5vzrH1Yp4_r5hrxLsVaO0dTdR6EG1Ft8tMcWSYA@mail.gmail.com>
X-Gm-Features: ATxdqUGMePn8O1hoCaC0DhO2eijxkVk5QWGVR9M4_P4K2Lak7-glCj_GgyFUnD8
Message-ID: <CAJZ5v0hsJr+5vzrH1Yp4_r5hrxLsVaO0dTdR6EG1Ft8tMcWSYA@mail.gmail.com>
Subject: Re: [PATCH v1 12/19] ACPICA: Introduce ACPI_NONSTRING
To: Kees Cook <kees@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>, 
	Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 8:35=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Apr 25, 2025 at 09:27:58PM +0200, Rafael J. Wysocki wrote:
> > From: Kees Cook <kees@kernel.org>
> >
> > ACPICA commit 878823ca20f1987cba0c9d4c1056be0d117ea4fe
> >
> > In order to distinguish character arrays from C Strings (i.e. strings w=
ith
> > a terminating NUL character), add support for the "nonstring" attribute
> > provided by GCC. (A better name might be "ACPI_NONCSTRING", but that's
> > the attribute name, so stick to the existing naming convention.)
> >
> > GCC 15's -Wunterminated-string-initialization will warn about truncatio=
n
> > of the NUL byte for string initializers unless the destination is marke=
d
> > with "nonstring". Prepare for applying this attribute to the project.
> >
> > Link: https://github.com/acpica/acpica/commit/878823ca
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Whoops, I missed adding my S-o-b to the original upstream ACPICA commit.
> Please consider this:
>
> Signed-off-by: Kees Cook <kees@kernel.org>

Added, thanks!

