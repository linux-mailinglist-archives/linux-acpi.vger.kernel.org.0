Return-Path: <linux-acpi+bounces-17701-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F10DBCB74B
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 04:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D99D4032DD
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 02:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B10124DD17;
	Fri, 10 Oct 2025 02:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elQ/QoLE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB219211A09
	for <linux-acpi@vger.kernel.org>; Fri, 10 Oct 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760064527; cv=none; b=pWMEFFO6BWXOprQwHXdbFOKZ3nn7e+sEuANyBThcTTeHMDm5xGjnJ+Xcz5ORLLZgrDvavyo7TgZrcg+Om/TyOO0orZjRcIL9NgVgwgxb4LXmInjvq+GzUapF0TCchNQiMKq6FV0GYNs01cKKK1cF8q8591XI7fJVeOT517ZrYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760064527; c=relaxed/simple;
	bh=SUvjTYrAKggs3w1tKlxCJydt04WX0hyij5ZVnNtO2rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1NdutBP80nBv+hXo/214Q8J4H2MAn8R7/4NECrTsHfMnixHaYtzn7TBfcRPatf1oH1nMVevoWJReuS7plBWgkYVm/0Pv/VcdS5VkMToXafCrxP243/luBayTfox51C94Bn1dQ8lciI7TlRLqDNbLwhi82mQTVyFZXSia/jMuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elQ/QoLE; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-74435335177so41239487b3.0
        for <linux-acpi@vger.kernel.org>; Thu, 09 Oct 2025 19:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760064523; x=1760669323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUvjTYrAKggs3w1tKlxCJydt04WX0hyij5ZVnNtO2rY=;
        b=elQ/QoLEl07oguGQwVeaLuPvx9pg+ZF3HObzItQAr16R2PwjJJ/BJhHlsBagHWRo1E
         q4f4I5TainPicRHfP4mxi/QA8fweTGrjQlrXERSkdlr6KgU4ZilfiRp9i5MkNzxdmJFE
         GqtJBFbDrYJM4r8+ph0NGbgZ2YQn4dQX2PL+zpJpSkH6dn2eia2X9CYfK8q38r3RGNos
         FYWwKOjsxbNPoX+OU5D0/LZM5lIAyQ56jv8iMtnZPsc8rn7rN4UBS2EkrASRagSQ6iHh
         M0HiA7o+kBUytakpqhUfCayQ9hhTHxglANqJie8IdxhcFjjr6XDM3XOMyO0pRXWHPZL7
         uJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760064523; x=1760669323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUvjTYrAKggs3w1tKlxCJydt04WX0hyij5ZVnNtO2rY=;
        b=HbXyvVQe9EDaud0qop3oDJjRaT8vZ3X6dago782e0bU2k7JXMR/6AFhbrt2Y31C30d
         PDWnN0d13W9LNxWHhl2ioVqvKo3o+MFqAuxuGyde8OdMAH6Uz1YpTjcOaceDkyoK8oAV
         1GwzCpftV/Ph0bwpA7s+EvTLxWmnXXjgp9yH8t/BmTOUywm+zyxUU0p0p1ifDFyTyuXe
         MCxu8Gqcqs7Ndec4PbV+bRsIZFOXS3PljOq2e6Ae1zgN2ZeQSjuDeTEqGSrx4jtkKmtM
         47064SwnBXziUqzNzhQu9QYtRHs8etvjMNUDtu7sDsxHhca2CdVwTpR74wnM2TxWO3dh
         IR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiGaqJVeESrhc6Z9mNv69GAQ7bSMlgklhY+q6inbEC8+10VOUm9sDXoHLkQzpvOJruDWVe1sACG7ae@vger.kernel.org
X-Gm-Message-State: AOJu0YyYYvZWKmWfL7qAmiSERf5vezey83purTioLuX00AGwqYIvAql/
	TvngYYDm1zeoIc/g8zDVJViEhmXEuKdO6WSwnuOf8tYERTOqL2VNVhZrobWzhmRwRe7kf6hfamX
	KtrUkBG9cKnbjCUIsdIPDXicD/2n53Tw=
X-Gm-Gg: ASbGncv1fjQpVjV+Ozuq36855DcmBsAy9SPBkwlSQiT63mRoAIuNBQbzVXu5/7klBxI
	6lRShLbKX5PV5dWWNnG6+TZbrDipp5thPtu4+a5IWpINyYAqdMMk9D1B+6SvdonsEsiX0xGY2PX
	82UaZ3Q3uWoDX3f0bJY9wAR5ezbcJG/B+uhLASkvMZypwfczYzNsAhGNw0gQfih4OoMCRCfltD8
	dG1oHR7HHRqsKU/Iz/tAbvRKji1OWuYxVAXi91Y9A==
X-Google-Smtp-Source: AGHT+IE/ruZR0Nl+gZjd7KSfaZ+4Yt5azf8Eoz6teA2EZ5XcCIQ6BBXF8AxOCZshaSTrV+l7WDzDAJYCcqNIJ+IMELc=
X-Received: by 2002:a53:cd0e:0:b0:635:4ed0:571e with SMTP id
 956f58d0204a3-63ccc4fd4b5mr7697871d50.22.1760064522649; Thu, 09 Oct 2025
 19:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <20250913003842.41944-22-safinaskar@gmail.com>
 <a079375f-38c2-4f38-b2be-57737084fde8@kernel.org>
In-Reply-To: <a079375f-38c2-4f38-b2be-57737084fde8@kernel.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 05:48:06 +0300
X-Gm-Features: AS18NWC-iakvkxLfUlO1LRxakg0fg4KV7Trw_hsIF2wxGpnmpWZvHTCQ7Z3GaoE
Message-ID: <CAPnZJGDK08eDWaMTmvVQwkAAThUvgB0XgAapqqV4_ZmWeay-iw@mail.gmail.com>
Subject: Re: [PATCH RESEND 21/62] init: remove all mentions of root=/dev/ram*
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 1:06=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> Please wrap commit message according to Linux coding style / submission
I will do this for v2

> To me your patchset is way too big bomb, too difficult to review. You
v2 will be small.

--
Askar Safin

