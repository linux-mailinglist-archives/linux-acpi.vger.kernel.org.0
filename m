Return-Path: <linux-acpi+bounces-7957-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA8096454A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 14:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D01C248CC
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 12:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A131B655D;
	Thu, 29 Aug 2024 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrUrXNFS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206661AED2C;
	Thu, 29 Aug 2024 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935499; cv=none; b=VC+yD4OUmQrWFhbYuZwnLaBMfbK7BalmgKee0zo2yWl74qduNXXEMU3YOeqblV2p0me5sPRhW4VtCKMjqfJPdpNm65za34DYeyUR6sB8llMcPQCld82oPttWSopV7EtT4sMBjtJypYwqpktUn8OiX1mrYUdEgX7bXHJfITfPY6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935499; c=relaxed/simple;
	bh=bmThkBbfzGY/zRaA5TdivH5V4F0RokpFhyMV8XTIb00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlRaXu1sAdCU02IxLWRoJF05+vUmEAXQ0tXHfzxaJs3mSRQstgCU3oct3jDG2Xyw8P9IKkywFcpYA7tENJoNc05UtKos7+14ZZzvmmiU++LdslbLdC51llIpJVtQAlI4ifnd0HYgpuMVTc43I/JOj3k+5HlT0nAuVpcQ/9UmcnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrUrXNFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9835DC4CEC3;
	Thu, 29 Aug 2024 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724935498;
	bh=bmThkBbfzGY/zRaA5TdivH5V4F0RokpFhyMV8XTIb00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WrUrXNFS4FihIFzDc0Q/i+zPfg/YREyBdRDuHsjyxzF9UlPrhLHp07WSuk612YIPo
	 L0eD5kobl+XolFpq3hFjDfWmCAObSEurgZFX7nZdziq4WLc2mZcLmtk8qiU+TkbAyM
	 VsOFO83/OwrSkm+viX+wLa0VkFfoueGpmsJP2rQ4MTdpAphz/3758RlHP9CuF6QZss
	 5NxulAKMsO5saNofcI3DYj0vdTopT1J2fHFAWteth/oRRYAgFL9s9K+WWptJqo6n1d
	 KcpDi+Urnhau5BE5y5RbB9T8LhXYZluHWZuDow0sh3xLVdTmQMSqiU4io4Y1sV9FPr
	 uRiZfyXayy76A==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2701c010388so220182fac.0;
        Thu, 29 Aug 2024 05:44:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVu6p+/49ZouWBE0VDTTnjTzulga8j8RBmCMroMj8Viyp+8/0DKxinL/OmnUuYMnXGljYGbzAO70ncBSXkL@vger.kernel.org, AJvYcCX+gq4upTSG1Q7lPk6TEWNFjfSmN03HYWLeBcWC6yoQjLOZShLi/YflCHFVVnwDVIrNKn8YvozsEZRT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4YDPs1LoEF43bvHjo5UDCu6vVq92MYSYm8OMxiOEbWZMkWb19
	0YZnKy8RZ9Hsi4qKY9T6DYPiOdiWz5x3cb1Hmc0cwtE96g5Y6Xv44XF76kS7g1JMuQe86JWj0Ta
	sL35z3huU+XlvXvhXB7ub4QWw8t4=
X-Google-Smtp-Source: AGHT+IGwwcMeXsd6teP/NpzkS3WieVlJLs/+1rpwoZoBxyYX9HPJGboOAyMFF/OmSM2K7zH72Y53RWKmWyRG7LowxaQ=
X-Received: by 2002:a05:6871:2b2a:b0:270:184b:ccd9 with SMTP id
 586e51a60fabf-277902e2b7emr2814143fac.39.1724935497901; Thu, 29 Aug 2024
 05:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827025821.2099068-1-jiaqing.zhao@linux.intel.com>
In-Reply-To: <20240827025821.2099068-1-jiaqing.zhao@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Aug 2024 14:44:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jc7_k0GEVYD06v-VJ5Mc9af2MV4taXTxJ9SnZ6+Q3n3A@mail.gmail.com>
Message-ID: <CAJZ5v0jc7_k0GEVYD06v-VJ5Mc9af2MV4taXTxJ9SnZ6+Q3n3A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] S3 wakeup support for hardware reduced model
To: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:58=E2=80=AFAM Jiaqing Zhao
<jiaqing.zhao@linux.intel.com> wrote:
>
> S3 wakeup requires waking vector in FACS table, which is typically set
> by OS. This patchset enables FACS table support and allows setting
> waking vector in "Hardware-reduced ACPI support only" builds
> (CONFIG_ACPI_REDUCED_HARDWARE_ONLY=3Dy).
>
> Link: https://github.com/acpica/acpica/pull/960
> Link: https://github.com/acpica/acpica/commit/ee53ed6b5452612bb44af542b68=
d605f8b2b1104
>
> v2->v3:
> * Remove extra code style changes to align with original ACPICA commit.
> v1->v2:
> * Not removing acpi_hw_set_firmware_waking_vector() declaration in
>   hwxfsleep.c
> * Change was merged in ACPICA project, add links to it.
>
> Jiaqing Zhao (2):
>   ACPICA: Detect FACS in reduced hardware build
>   ACPICA: Allow setting waking vector on reduced hardware platforms
>
>  drivers/acpi/acpica/acglobal.h  |  6 +-----
>  drivers/acpi/acpica/hwxfsleep.c | 15 ++++++---------
>  drivers/acpi/acpica/tbutils.c   |  2 --
>  drivers/acpi/acpica/utxfinit.c  | 24 ++++++++++++------------
>  include/acpi/acconfig.h         |  1 -
>  include/acpi/acpixf.h           |  8 ++++----
>  6 files changed, 23 insertions(+), 33 deletions(-)
>
> --

Both patches applied as 6.12 material, thanks!

