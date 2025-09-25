Return-Path: <linux-acpi+bounces-17305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 500D3B9F62A
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F268169E9B
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 12:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55551DB958;
	Thu, 25 Sep 2025 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVlprIrC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D4210A1E
	for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2025 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805122; cv=none; b=QlNCR2DEsZP1XIgrZzM/Ab0WKF2Q+ZtbpMiAwsXxLKi5GKXYPc63j7OZXQlnHh6kVUZ+u0hHe0CFt7njzy1Vh3h33ZW+tCqgdnGMP/1Zhiz81OlQGpGwlpa16qCoYULNiuV903PeONKptPT3Enq5xVUIf+LtPdPlhpLeA36N58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805122; c=relaxed/simple;
	bh=RjYUCOtNAbvvco8vthWVp82cdv9eEy+4Psafoq84FY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxvtHx+DnvWQAsg6xpIdCqF8/UIiOoBUvZl6NshC7O1V30/GJsKvC4CnJnIMVVrk15g6THppAF11VLcR1tEf2kh7Zou1wliHm/qwGaPLZwuxm18nZTf2JjYEYUcGHu4tQKspD1UJKqb3nYi8C1MnUIdkmuOAQjlwEtfTveBqInQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVlprIrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AE1C4AF09
	for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2025 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758805122;
	bh=RjYUCOtNAbvvco8vthWVp82cdv9eEy+4Psafoq84FY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qVlprIrC7+BK2+O3WiAbWUSIO/Wzkv0WDPRF7LNDK2sKscexjwoVJEIYmfAzYVXgW
	 aCSPYV6StlRFMXvdsrHpxMBcsY8GXha2EcBo8JIQt9KPkwKf/BJgowuczBrS4D6AuI
	 ad1fx7qB07iECH+WDsFqqhs6iL8p2A/62CNoVsqinnth3V51+9pg89N1ufw3o0d+8k
	 Dd8sPLlERv7Pd3Hv0R4vDL/y79wFfWnSU68GTEjf7KvvHV0DwIaKyVQ7xk1lUm9XVh
	 Go89OlhUWnvqNiyI1MQJeazhiLtXw+V9zJinxoToa+psGt8McomejzBZ/T4fVptovc
	 auDyy80YsNzLw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30cceb749d7so340307fac.2
        for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2025 05:58:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQKzwP/lpvH3FaYEOt87ChF3Q2ozocJQsGq6lmambBZlljr673yenDBtSacacrOSh9TKwgfiGryk0k@vger.kernel.org
X-Gm-Message-State: AOJu0YybS2UYDcsnyAF52A/m/HypRa/cGSopyNZqjrijTYy052gKYYhv
	lPzp243aFJUvQoWqDhW3DNKilsGOcuXCl2eOWN0vcuV/e/90zlr+RWQFss27+5ppzxoMMAMjX1e
	r2B6Bbe5XBqOyN0xcgfTE+jiEPPKmSbc=
X-Google-Smtp-Source: AGHT+IEsxnkbDv6VaxPRzOho5nGSBZ0rmXl4oLsr98I7SW3ixSbV7GBzYnRPlz5VE+V0N8TvSAzt2cAgUqwUNw6hV9I=
X-Received: by 2002:a05:6870:f691:b0:30b:b045:18df with SMTP id
 586e51a60fabf-35ee98c5f0amr1765468fac.35.1758805121527; Thu, 25 Sep 2025
 05:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR11MB6882D35FD948900136B1C632AA1FA@PH7PR11MB6882.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB6882D35FD948900136B1C632AA1FA@PH7PR11MB6882.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Sep 2025 14:58:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h1Tz4OBCinWCaXQ2uije_pjpd-wexCNXwDaNrvZTCfsQ@mail.gmail.com>
X-Gm-Features: AS18NWDO_k8CpWJ5CM6cGde_V4Pa7pValf-onENnAfTNckZ8V1EqmZobbam8Bec
Message-ID: <CAJZ5v0h1Tz4OBCinWCaXQ2uije_pjpd-wexCNXwDaNrvZTCfsQ@mail.gmail.com>
Subject: Re: Linux APIs for parsing ACPI tables
To: "Autee, Priya V" <priya.v.autee@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 
	"Herdrich, Andrew J" <andrew.j.herdrich@intel.com>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cc: linux-acpi

Hi,

On Thu, Sep 25, 2025 at 5:50=E2=80=AFAM Autee, Priya V <priya.v.autee@intel=
.com> wrote:
>
> Hi Rafael,
>
> We are looking for ACPI Parsing APIs. Could you please let me know if you=
 are able to share the pointers for the same?
>
> Our objective is to look at existing ACPI Parsing user-space APIs and use=
 it for stitching various ACPI objects like HMAT/SRAT etc. to gather memory=
 characteristics (latency and bandwidth per memory range).

I gather that you are talking about ACPI tables that don't contain
definition blocks (ie. no AML).

The specific parsing algorithm for each table depends on how exactly
the given table is defined in the ACPI specification.

The tables mentioned above are processed by the code in drivers/acpi/numa/

Thanks!

