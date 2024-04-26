Return-Path: <linux-acpi+bounces-5426-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF218B3D83
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Apr 2024 19:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFB72834F6
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Apr 2024 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE598157492;
	Fri, 26 Apr 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBoRJ9T3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8515623B
	for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150958; cv=none; b=OJoOu0Xiibp2zoX/zqFKLHzFwQJQaiDD4VDj007QIy+OK1OUiduh+TPGacHfFXlJl6MLHZOsV8UOlxiqYAEC3KcInhjCtMbSWYkdFjeUdF+TXrhrS/WFBfdshre8lem8stISz4OH2UozYBtwpJixwV6TMeCHdWh7Pjsuuoe15HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150958; c=relaxed/simple;
	bh=LHa2qNEP0K6+La1C8rZWM6BBpa3ciPDKWpgh1OOGcpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJcD7U5PrszCdzJ4bjIgLKE80Utmg6IGtSmd3lkl8kueEDIlOZQdI7NcpuhIdn0USmZ8E8NUjrg2WIdBgxb7aXjjg76uCG65/e4iIdho+sraQJQ3aZ5S9aqQ+K+wIAyR9b6vb+fn8kROEEjdn5F0mJONwHpHPQkY1jaYHA3oD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBoRJ9T3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF2CC116B1
	for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2024 17:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714150958;
	bh=LHa2qNEP0K6+La1C8rZWM6BBpa3ciPDKWpgh1OOGcpw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sBoRJ9T3Q05EAVnMM+a38TrMjoFH5cROQt/gXEi5AwygTdIegerCLboHKiluuWhf+
	 /lXZuSJ+gcFyVq0nNL8wlVTSCFThsQrSPN4bGKGUixoks7dxKRK+wGnYsHGCEXUXbH
	 QK0pGJuLO8yaRBDVhd3Yl77riU54oY0lbTPl4T3awMpVP72Aqsd/rUXYUTZfDe5zQr
	 oHiSwwXiOD5NEaSSfrHLuKvc8dKby86V8C+/x2hfyRAIW0r+Su6eU3O7gdlNkjO5yG
	 //NIhxjZvCdRRH+oGgvgKuhPTqqAtwpXTFE8QQPD0vcTqPRyfsPcWOfW1dZn6o0Y2x
	 6OZkBaYKSuAqQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5acdbfa6e95so560607eaf.3
        for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2024 10:02:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YxCDJJJYa//1Fd1OJQoNkOIK+MPqDWow2O2pUsnmEwp7Wq9OEQ4
	hG3idhtKMCkjOs/K8vz82Ev/A447FhD6gmnvbHzyfh4oy+dsxIx7jge9m5to4vgmkFuNUp7X/Cl
	hFnIE8z/Lltx9Qm/RgHNgLj9UmJQ=
X-Google-Smtp-Source: AGHT+IHImSh6aU0z+bWMBryU8vQ2uG+Hg4lMCJjksCuvh+nNqxxHtZseHPjsQPWhci5hfWvARqDC2pY9bkSQiIPHtSY=
X-Received: by 2002:a05:6870:d690:b0:239:8686:73b6 with SMTP id
 z16-20020a056870d69000b00239868673b6mr3297306oap.5.1714150957540; Fri, 26 Apr
 2024 10:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422181342.810350-1-sakari.ailus@linux.intel.com> <Zie3wYZTub0mWTPC@smile.fi.intel.com>
In-Reply-To: <Zie3wYZTub0mWTPC@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Apr 2024 19:02:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jq6HZCRBaZ1Sin-BOMWeGd4FKXaNa9nWh+TGEkvVGmOQ@mail.gmail.com>
Message-ID: <CAJZ5v0jq6HZCRBaZ1Sin-BOMWeGd4FKXaNa9nWh+TGEkvVGmOQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: property: Add reference to UEFI DSD Guide
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, 
	Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, mika.westerberg@intel.com, 
	"Liao, Bard" <bard.liao@intel.com>, "Ujfalusi, Peter" <peter.ujfalusi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 3:29=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Apr 22, 2024 at 09:13:42PM +0300, Sakari Ailus wrote:
> > The UEFI DSD Guide specifies a number of GUIDs supported by the _DSD
> > parser. Point to the DSD Guide in the documentation.
>
> Makes sense to clarify, indeed.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied as 6.10 material, thanks!

