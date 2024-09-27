Return-Path: <linux-acpi+bounces-8472-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA00A988B2B
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 22:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0636B2856D4
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 20:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06C71C2325;
	Fri, 27 Sep 2024 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xnb/dBLb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C03218B;
	Fri, 27 Sep 2024 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468271; cv=none; b=Z6RBzYAo9XBtaF7tOPEvIiTao4W6wxv6ppdczdZITeiyE3/hNMlxcga1preJpPEWC4XzWFyIR8UfnUJ2yYVQ0mZgf2k86uKpf8bFBaBp+NFdFs+08HKGpa7npt8s9HP4LpbTWYAM+0PRUxqrovP/JtxL7xNqDG3COYGKMzQLeQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468271; c=relaxed/simple;
	bh=ODzpiWQ1wI3SCclq0vMNeqtz8SkjFLd4AsW0QtwYcC4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WykeeaPlGETpeiN1f73nbfEh2+G9gTqGWg6D4w5JS8xozy2rtxuBvL8Hvrt69jJxMm3DNxLQkhFDvKe+o2MNkZNkb4TjQwrDeeymONEq767L2nNASQMcD6qr6mjQOcD/507rI4EBwAcVX4SdYNVPRoFFtMVDwKFdUIe05wMalKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xnb/dBLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9488C4CEC4;
	Fri, 27 Sep 2024 20:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727468270;
	bh=ODzpiWQ1wI3SCclq0vMNeqtz8SkjFLd4AsW0QtwYcC4=;
	h=From:Date:Subject:To:Cc:From;
	b=Xnb/dBLbDjusMSnZEV0FTwPWkn7IQ3lTXxKraYP7BtNsGItkhWyr6huGoFDhoTkus
	 POjvemEjUxUuDwoWpzGYzYw6FiTVxNVy5TCV89L5p8WX8BSR1Qebj7jKEiJ+9uov7Z
	 hKam1e3m9ZQs06nX/Aca1cfzO/AOFzVXZ1/ZInYukdQWlNmjdFn5CQbo6acIfRV1ZG
	 xtldbkNIFRSR5PtgLGZoA/6OZ8Cysfpz7dfOjmXdc+O1US7jaQbUjjFGsJ28u6OqQO
	 mFhy35HvwE+6qTRPB0oeaFgHdvnJTYsCJkmkselT0/g+sG93wf/XE7/M+t/+oHG4an
	 +GQFkn+caoF9A==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e5a0519ef3so1198642eaf.0;
        Fri, 27 Sep 2024 13:17:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVz3BtGVSb06mzCjj2rsdvQPpxvBBRqRNYZDgzJt5qZSF/NoHpLyFohnw65OtiztmFVpnbCeQmckDnXDUZx@vger.kernel.org, AJvYcCWjNoROFYRhxAVpqCUe630tmVEsgTRIUuOpaAAPNUintIrTBUOOUtYYlEmV0694aNW94lOSBB5cYkb7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3XPAfOxQSTmCeO5klncGWSaZDzpkqsjpojAdA7UaHBuCciky
	z+AUt4MNkgaYo1ii9MTNRdJwyC7uU0ejJ6OuX2S3pMy+V0nRE/nnWTL6rWeM87WNBJrA6uovPDh
	FbixhSOmKs1H6NEE44uf1qUaj2L8=
X-Google-Smtp-Source: AGHT+IGtYXKDkmRriYiOne9+BT8e1vMyd/Pj1uR0Px7qVkk/1u8BkWNbDCKL8xZa7IulPQvr/VMasvnqq9mQgREgG2Q=
X-Received: by 2002:a05:6820:2208:b0:5e1:c377:f5c2 with SMTP id
 006d021491bc7-5e772791c60mr2631852eaf.5.1727468270156; Fri, 27 Sep 2024
 13:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Sep 2024 22:17:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZO4f8q_BYYYkMsEPzQYmFG5GAQrj8=g0b7GV6Rmf=Bw@mail.gmail.com>
Message-ID: <CAJZ5v0iZO4f8q_BYYYkMsEPzQYmFG5GAQrj8=g0b7GV6Rmf=Bw@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.12-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.12-rc1-2

with top-most commit 4c411cca33cf1c21946b710b2eb59aca9f646703

 intel_idle: fix ACPI _CST matching for newer Xeon platforms

on top of commit 02824a5fd11f99b4637668926a59aab3698b46a9

 Merge tag 'pm-6.12-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive a power management fix for 6.12-rc1.

This fixes idle states enumeration in the intel_idle driver on
platforms supporting multiple flavors of the C6 idle state (Artem
Bityutskiy).

Thanks!


---------------

Artem Bityutskiy (1):
      intel_idle: fix ACPI _CST matching for newer Xeon platforms

---------------

 drivers/idle/intel_idle.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

