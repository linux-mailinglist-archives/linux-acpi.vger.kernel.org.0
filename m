Return-Path: <linux-acpi+bounces-12804-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D94A7E926
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 19:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2433B30C5
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 17:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CC2218AC0;
	Mon,  7 Apr 2025 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNB0aCUV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E162215769
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2025 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048517; cv=none; b=AvlsuLntk1Mc5tavmB6SHekVgvwbcA1mj4SISPDDdtvukl8BnAgDjNGmCoS/TE7VFesZySEzCpbzzhxbrAbGmseICxBR+pHi/zvIqPVvhP5iE358sKNGRYZWHaxYsHJacQ/CgfvUf5iN2S+Hrm8FPkKiga/B/zyBTZH2Ip8xNW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048517; c=relaxed/simple;
	bh=Nxs8UIgiqd3YwVHNimrzwSZz6GDlTfV8Cvz4JdVn0wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LX1jPBc5hRc9sMN6V/9lwVrlZ29hP3iRAjagWte0gn7IJWyZQGOWunTfft0cbV1vhpEuX0wctPB2W27QXzKkQGSKWjk4oBUiX+wnnuQgiifgP2yHDc+yzlJaX0tW36cmfiwAo7Jki1mJGpM7u0g73qNuEmkgnojqumiLUCRYFSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNB0aCUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E70C4AF09
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2025 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744048517;
	bh=Nxs8UIgiqd3YwVHNimrzwSZz6GDlTfV8Cvz4JdVn0wU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PNB0aCUVCSohBQeLMm2bGp6Tf1ny2BJL9K9ghsLuK7FAxbPtNB358vUx4PGMofVtx
	 6IL9AHjRirVQodvnTOupCzJm1WTZ/7aH+HKP/nGrMkKm/i7kfrHqkfebYNCbVxJzF7
	 CpiNII4Ar10wwNLiaLqbnKLffK+vX4cu0wuOM0QgUGSNMHftvKryKeF3jzO/HppzEp
	 fgsoKremQf5pvRQQmGAXiJFMbUtw+UjZeMV2EoCm+8ahFIlc8BdJXPT7v4VHe3Hybs
	 jNX8C204FMshosXJROKAz3F+T5M6fEGliVEXjVNdyQcaHnUyvmUXQ5wD34iggwGQzF
	 Gsfq+M5osAnPw==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72bb97260ceso1200518a34.1
        for <linux-acpi@vger.kernel.org>; Mon, 07 Apr 2025 10:55:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcMotbnAdJUQg3yxgM0WWmeDtA4lEAisK1+r7ADUhjrmwxeH5lhEQ2sbIUYS2a0YLBLO0mdfY9CTd9@vger.kernel.org
X-Gm-Message-State: AOJu0YyK4ZudVFk+3buE8idIJ92baJMvJfukPv1yTv7mV8wbWSh1rqzQ
	srcizXB9PLn3qVG8J7U64zwgfc+MfUnt5eLbd+zZVddP5S0FzKH/Q4EqUEk4K4NtnV30S5dLERl
	9oFAQAgF1rVHEn1ltDS4gFH2JClY=
X-Google-Smtp-Source: AGHT+IHB50DdFI8JCiHlQLppwrcbJ7qwitbLrRCoE93/iQOIaTH7qeBpNUXYzWAxzCOKYKOY3aZmLUcSH/pKC4WUsnM=
X-Received: by 2002:a05:6830:3987:b0:727:3111:1416 with SMTP id
 46e09a7af769-72e40ec16a0mr6326668a34.24.1744048516325; Mon, 07 Apr 2025
 10:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404145034.2608574-1-superm1@kernel.org> <b08a4411-0bce-412b-b69a-13c060f1d0cb@mail.com>
In-Reply-To: <b08a4411-0bce-412b-b69a-13c060f1d0cb@mail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Apr 2025 19:55:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hCL6XZbmmsLUMeynp7k+HMz_9GB6VBz_vU5GimWH+wnQ@mail.gmail.com>
X-Gm-Features: ATxdqUEO3fuuX45ZizcSWerSa8gWXQe1tn6l1rSbxTGPQLLaU04aDZpuoE2pZdw
Message-ID: <CAJZ5v0hCL6XZbmmsLUMeynp7k+HMz_9GB6VBz_vU5GimWH+wnQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: button: Only send `KEY_POWER` for `ACPI_BUTTON_NOTIFY_STATUS`
To: Ian Laurie <nixuser@mail.com>, Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, 
	Yijun Shen <yijun_shen@dell.com>, Richard Gong <richard.gong@amd.com>, rafael.j.wysocki@intel.com, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 4:13=E2=80=AFAM Ian Laurie <nixuser@mail.com> wrote:
>
> Downloaded the build Justin did on Koji, looks good after 24 hours, no
> bugus events.
>
> Tested-by: Ian Laurie <nixuser@mail.com>

Applied as 6.15-rc material, thanks!

