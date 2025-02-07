Return-Path: <linux-acpi+bounces-10922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D01A2C328
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Feb 2025 14:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CCA16AA91
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Feb 2025 13:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423D11DA10C;
	Fri,  7 Feb 2025 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5d8RaYe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182512417FE;
	Fri,  7 Feb 2025 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738933275; cv=none; b=T29iy19kuohPzMk3+VYJ+tY/g6gEl84oMoclLXkTCqpfDc9u5NUQhaDUo5I+dy+QpJ6/JOC3kBpAsbUDzXknL51BwHE0KcPm3Q2sSu0YjfrpimqoMr1DAlbK6/81vwJULvFpZ2Hm9gngjBGRZRafKwzB9d9tPRWRjp0/0q2jviU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738933275; c=relaxed/simple;
	bh=Ri+nZKhrqNqc4K6NynU1QfDk1qq/yEzFehK1JRmB5q8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jXoFUcy8q+XegIRs/aiUVXSfz9pJa38ly6/y54zhDXW97V2yh/4FIOcu45NvVMukX/5I3TW4e6q5M3yzAqQ1kc2NICsX12i3uZy1rRx/5unRUSogE5jYtts6z4xK0Uveyptl66x30px6rBs/6kn2e2siNxLbBQjePBkXw3DJaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5d8RaYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F57C4CED6;
	Fri,  7 Feb 2025 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738933274;
	bh=Ri+nZKhrqNqc4K6NynU1QfDk1qq/yEzFehK1JRmB5q8=;
	h=From:Date:Subject:To:Cc:From;
	b=p5d8RaYeBUhddRQvltb2j5Wc/pwV5SIZiqgwdwveFYtxRYjxBWFTuaYOWB+wBBDzS
	 dFao1r9KJPoHzLnpFJqGOhmuPiT6nDrhaerMtLBcuy0gFdPs5OGAnkCG18mZniIasr
	 n04TpLDe4/92MHfB4sWTG+2tUvDARgxpSKiBt1AxFb7sI2UY8Wug12SSLVNEFSetMR
	 aYWObCzmeYILgCcfcV0WrEjivAg2unuuP84KyTjnobmeEraGJNrCNr/8wduj59cxOg
	 /2OFyr4QmqSQfd9DngZTpORRRXfdqLna6u7hB/15WTEKifh5i4QvNY2w/Ej7+rHz8c
	 TgthbgA4e+9cQ==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb7f3b1342so1077154b6e.1;
        Fri, 07 Feb 2025 05:01:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdfWfvDyxLRveKsSCeJvbuwxxEY3Mu8Y//Wy9pWl3scxdEr1MNIArsni0OasS0MZEinWw2tsOngxNCXSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrd+I+iseod4hICAOer1T5OpIxIp9o9PbV193OdwXUIISzbj3F
	j8JT4l3T/AMQK+nBNQwVrWrGwzZxWiK1Bs2TYNE1xT0bNuIPC7BWuU3vF2wDjEl6b46gg0+7/Oi
	nwfZ+Fcy65mLmhadpqSdORmdEdwQ=
X-Google-Smtp-Source: AGHT+IGDKZGSlFQXEoQ9r7INWiaurDqemMuFbZGmORsYRZs5Ad39G3qermyXYv8nzNaBWrJ8ybp7AxqGkjeb48HrVNs=
X-Received: by 2002:a05:6808:181c:b0:3eb:6dd3:12bf with SMTP id
 5614622812f47-3f392340277mr2194231b6e.28.1738933273796; Fri, 07 Feb 2025
 05:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Feb 2025 14:01:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hOVsML89netZiY751QiPqQD-7mUYxpdJFwNmxgxu6JZA@mail.gmail.com>
X-Gm-Features: AWEUYZkxaEmVneClcUk3VaH3LiRB1q8kbPCkhQqfDtFTFo_KNqCp1DVjctCWvXM
Message-ID: <CAJZ5v0hOVsML89netZiY751QiPqQD-7mUYxpdJFwNmxgxu6JZA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.14-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.14-rc2

with top-most commit 3e3e377dd1f300bbdd230533686ce9c9f4f8a90d

 Merge branches 'acpi-property' and 'acpi-resource'

on top of commit 2014c95afecee3e76ca4a56956a936e23283f05b

 Linux 6.14-rc1

to receive ACPI fixes for 6.14-rc2.

These fix three assorted issues, including one recent regression:

 - Add an ACPI IRQ override quirk for Eluktronics MECH-17 to make the
   internal keyboard work (Gannon Kolding).

 - Make acpi_data_prop_read() reflect the OF counterpart behavior in
   error cases (Andy Shevchenko).

 - Remove recently added strict ACPI PRM handler address checks that
   prevented PRM from working on some platforms in the field (Aubrey
   Li).

Thanks!


---------------

Andy Shevchenko (1):
      ACPI: property: Fix return value for nval == 0 in acpi_data_prop_read()

Aubrey Li (1):
      ACPI: PRM: Remove unnecessary strict handler address checks

Gannon Kolding (1):
      ACPI: resource: IRQ override for Eluktronics MECH-17

---------------

 drivers/acpi/prmt.c     |  4 +---
 drivers/acpi/property.c | 10 +++++-----
 drivers/acpi/resource.c |  6 ++++++
 3 files changed, 12 insertions(+), 8 deletions(-)

