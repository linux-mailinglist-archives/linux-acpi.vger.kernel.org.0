Return-Path: <linux-acpi+bounces-1398-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D137E7956
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 07:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FDB1B20841
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 06:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E226FB7
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KZM9uTxe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE553BF
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 06:19:17 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A522161AC
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 22:19:15 -0800 (PST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A2E4B40C53
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 06:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1699596585;
	bh=dbMwBXBmEotT6dk1rDXulRhL3RKiFgxFvFzDuEEcJx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=KZM9uTxedJKiGXsELffIS/EpGGq5PCy6sEcg7yGMzuYDs7q2U3LhdT0a2xYjwo4Q0
	 qysXrhOCgaDgXqyVAOM3oonLI5lCPq2Q/Zr6c5DLdHv15OnvFmEEmxTfGJlj3RVCt1
	 UCeb7chPeGX4ugVH1xtOmr+sIfevvV4QOtsJjxcIAteoiEHZA8e1tPFUQwD2Bvd/Sg
	 9QS5EE/NpPOY3jlf02EdiSNYk43mLJQJIwIaFACL9LOrjRVsiARyUurdPCo8nrvSdC
	 LRozsIJGj16Ay1HdAr8eraT6N/v0Kv/d8dQPw6zsTRWmArDVOgHbVLfDf1iRLgZkj1
	 WlOrssekXx8pA==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-280184b2741so1704808a91.0
        for <linux-acpi@vger.kernel.org>; Thu, 09 Nov 2023 22:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699596584; x=1700201384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbMwBXBmEotT6dk1rDXulRhL3RKiFgxFvFzDuEEcJx8=;
        b=Ns4rjDWtlPkhijkTeSslR8Td4yHt1CWU1kC+EloZ/eQ4LL1gNNAnMuaD5YJbWrDiI8
         xMFbLounvGMTAa5FKXzpLkD3jczAFMF4Sauyz1nF80RfW3FXQvvF6qG+ATDmdqn1c3uK
         Q0oRSSpT3p2VsAqo3z5JWOaX1MGCrjkCHBqpmVBEC/t7OXG75vITlKbMA1N777PXV9Ie
         5zMs3MNefDgkIwk2zK0dFIVz6REwKuijYzL4QLGzYjA5/F/X3EcPUPbPIV/mwQFK5RCk
         ovzorKVXmgvzr+lEyAam3wjuaCgQXNrnW9S22sr8F7u9exl6xTr+K8WDAttmcLs7Wiyz
         H1bQ==
X-Gm-Message-State: AOJu0Yy9XPCsMLNEjTT4PzXE0w0wWB2UuK6z+TRvJRhlOPEQuuwEubN0
	K7yBh4QksAKJSJXyVzNGDmWq4cRu1iI4OH5fj8snCxnifGs3Cx8k5k8yxWEkcbFYN8/4MWkYsWJ
	3tyxB3BQYheetd2ljSH/s4VbGRUDCLunbFGb2gZUKk/Ilqj2/EgvczMc=
X-Received: by 2002:a17:90b:4c85:b0:280:6296:3d96 with SMTP id my5-20020a17090b4c8500b0028062963d96mr3622959pjb.41.1699596583971;
        Thu, 09 Nov 2023 22:09:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1wROyFVtufgqw/ZeSGGAbm8xifOocKozGCKWAhapxnMtc++Zwn+hYm7Zub9ci/y6pKeOOqpv3+EKkV4NfDoY=
X-Received: by 2002:a17:90b:4c85:b0:280:6296:3d96 with SMTP id
 my5-20020a17090b4c8500b0028062963d96mr3622942pjb.41.1699596583634; Thu, 09
 Nov 2023 22:09:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9f36fb06-64c4-4264-aaeb-4e1289e764c4@owenh.net>
In-Reply-To: <9f36fb06-64c4-4264-aaeb-4e1289e764c4@owenh.net>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 10 Nov 2023 08:09:11 +0200
Message-ID: <CAAd53p7BSesx=a1igTohoSkxrW+Hq8O7ArONFCK7uoDi12-T4A@mail.gmail.com>
Subject: Re: [REGRESSION]: acpi/nouveau: Hardware unavailable upon resume or
 suspend fails
To: "Owen T. Heisler" <writer@owenh.net>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@redhat.com>, dri-devel@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Owen,

On Fri, Nov 10, 2023 at 5:55=E2=80=AFAM Owen T. Heisler <writer@owenh.net> =
wrote:
>
> #regzbot introduced: 89c290ea758911e660878e26270e084d862c03b0
> #regzbot link: https://gitlab.freedesktop.org/drm/nouveau/-/issues/273
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218124

Thanks for the bug report. Do you prefer to continue the discussion
here, on gitlab or on bugzilla?

>
> ## Reproducing
>
> 1. Boot system to framebuffer console.
> 2. Run `systemctl suspend`. If undocked without secondary display,
> suspend fails. If docked with secondary display, suspend succeeds.
> 3. Resume from suspend if applicable.
> 4. System is now in a broken state.

So I guess we need to put those devices to ACPI D3 for suspend. Let's
discuss this on your preferred platform.

Kai-Heng

>
> ## Testing
>
> - culprit commit is 89c290ea758911e660878e26270e084d862c03b0
> - v6.6 fails
> - v6.6 with culprit commit reverted does not fail
> - Compiled with
> <https://gitlab.freedesktop.org/drm/nouveau/uploads/788d7faf22ba2884dcc09=
d7be931e813/v6.6-config1>
>
> ## Hardware
>
> - ThinkPad W530 2438-52U
> - Dock with Nvidia-connected DVI ports
> - Secondary display connected via DVI
> - Nvidia Optimus GPU switching system
>
> ```console
> $ lspci | grep -i vga
> 00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core
> processor Graphics Controller (rev 09)
> 01:00.0 VGA compatible controller: NVIDIA Corporation GK107GLM [Quadro
> K2000M] (rev a1)
> ```
>
> ## Decoded logs from v6.6
>
> - System is not docked and fails to suspend:
> <https://gitlab.freedesktop.org/drm/nouveau/uploads/fb8fdf5a6bed1b1491d25=
44ab67fa257/undocked.log>
> - System is docked and fails after resume:
> <https://gitlab.freedesktop.org/drm/nouveau/uploads/cb3d5ac55c01f663cd80f=
a000cd6a3b5/docked.log>

