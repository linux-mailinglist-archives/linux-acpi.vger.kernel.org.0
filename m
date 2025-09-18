Return-Path: <linux-acpi+bounces-17113-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6CCB86CEF
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 21:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 040077A85E2
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 19:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28944315D2C;
	Thu, 18 Sep 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNlT1dRM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ABD30CD8F
	for <linux-acpi@vger.kernel.org>; Thu, 18 Sep 2025 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225502; cv=none; b=YTXVmrwpCkpPc0VNQxJL0mQX+206HOxTp7gAN/I/zeMnEPnomSb8rNC29CfZ8goguhXFaN693qGjqeC3kIZxA5e3DexoO8qjRJdeqLjB/X76Yzvwz/NVI2WJqAqkRQSA5KEgsfGMYljhEwHMaxWCgo8aRvM+46QmMFlV6xw06p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225502; c=relaxed/simple;
	bh=hrTKVKMuOKbLilzSA+VEl+XSSF0VIocT2KvCzkuRjcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWDy3hikdEyMf3p8JyJCac/CR/+dNni1QhUi7vHOcYBg+EnCuA4KHTTRIrSbT0H6zaASPxFRQrPLlnHwK/57JW+uNYUMhtXPnijDBciTtsci9SNu8ajGf+evczyov0h5ZSiyVjK9erl/5bQyVk39pMtlNKvVMF9y0FBJVTVRaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNlT1dRM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b04ba58a84fso229632066b.2
        for <linux-acpi@vger.kernel.org>; Thu, 18 Sep 2025 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758225496; x=1758830296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9McvDjxp1cOQ8m8DQ7zr8KAOkClRv+R613f7KwPZqLk=;
        b=hNlT1dRMFhV3nNEO8OCPXfEiZjy7HadMXu4vRgp3Ipj8QW/pTjkxFRxYZEa69pe80J
         R5WZR6uBlmeIbF+VQhBUi3wnRJuDxh3ZSYPm2HtEzHdmYgYFzaLOTkBNZpxqwUsXFCi5
         xh48TC/I8mOWxP2I4D6qthvi1wAkVJadHw9+Q6aETqCdcS+tzshGNcO1qODnTVXpUxR3
         DzGuLf7FRf7YNLECrqzb9ayMBLdTqRvBk0ivmzKueGmRkmu1GRq1Uqn5Uc0kg8EqXgPJ
         5wCj9Urjk2M3jfgX+oYXsBuDx3I+zNM2GW5fMn6rB/kk6qlx/ZV55XBxceRxo80pIEfP
         n68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225496; x=1758830296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9McvDjxp1cOQ8m8DQ7zr8KAOkClRv+R613f7KwPZqLk=;
        b=KAkkNn+qOpwmuqHk8a/ezuwbFHM6oitUrL7xNWvLzoesxC0RyAfcXBScwZMRyEIorK
         PONTh5TYR4/yckfGfIeXvV0Fk2/qX/o1l7MzrVKiDI2A6gD8Hn4oGKGg0KomcqBFBXwG
         vmG/1rMhsFz5WuQrEcIGXxiWm6ScBom6QhH/n+Dv0rITg18nw3RRk9Il0UTADy54PmOl
         9K8LsbCPRPJtexW3+sl3RwJzlWg3OWBPCP6vOMf7aCDe8uDM/IpouXe8aEKWSATkzY6L
         j42k/BUdzenGNeseHl7J+82080dqxdE3TZv7KwyS9ki2L0ISaZ5I058VEiqcqFjfZjXB
         mu0w==
X-Forwarded-Encrypted: i=1; AJvYcCXSWaJ0jifVjHnYEiqY/QRjXOWT6jG14cAul/eZTIizkOAss4WxfReU9FUnwdItyxJnZxV9SWdL57FW@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBYjsAxtmjXkoCBSSnGSA0uDlOKMydnC/9fe5sIzHNKqD2knb
	L7z/YibhVMldtPCDp5HI6kFQDCx7sJT4V4ubcdL3mOs0GjpTZd4p734L
X-Gm-Gg: ASbGncseesM+MsrhN189DOwrWRIg3vep1JwvNKjmS5HGyWRhD1xMul8NbaMhZ4FYUGw
	r4Ykuq8C/xZjJg+RH+/3SzIV/aaxQjHy53VvwryL5aJSiuq9g9+dtaWf8wN6ye56UVIBQVk+lDM
	Jz89LGTpXqeys/mxP/n+c8UPyPxe6OeUv4vYEb1AevoPhEpOvMuR5bGdOBZAOGvPy1B8katNw0y
	sHbt0CkyHmcNJF3gmZT4vk/5HB6p83hU6HbSKgAR9hkcLfyxzR3Y5R3uPeuovmHwNQceuzZXzL9
	K5qy0pnl8x/EA5uMUsD1S0RNmjiRbYoPfgFNMNjn/B6aR4U6OdA/Oze0hsRCP44viUrtv+I89bJ
	LBTD6OtAzzIqpJGl9mJze7RErxv9uat3pFPmG6Q==
X-Google-Smtp-Source: AGHT+IH2NBu6L+bASXNqg9sJUcZ42MFCB2aqzEFiqoDEW6um54A4CtHcJnO37auTgFbi6nwycKDm8A==
X-Received: by 2002:a17:907:a089:b0:b19:969a:86 with SMTP id a640c23a62f3a-b24f35aa177mr45885966b.37.1758225496090;
        Thu, 18 Sep 2025 12:58:16 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fd1101c44sm264530466b.82.2025.09.18.12.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:58:15 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: nschichan@freebox.fr
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	cyphar@cyphar.com,
	devicetree@vger.kernel.org,
	ecurtin@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	mcgrof@kernel.org,
	mingo@redhat.com,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	patches@lists.linux.dev,
	rob@landley.net,
	safinaskar@gmail.com,
	sparclinux@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	x86@kernel.org
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
Date: Thu, 18 Sep 2025 22:58:06 +0300
Message-ID: <20250918195806.6337-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250918152830.438554-1-nschichan@freebox.fr>
References: <20250918152830.438554-1-nschichan@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When booting with root=/dev/ram0 in the kernel commandline,
> handle_initrd() where the deprecation message resides is never called,
> which is rather unfortunate (init/do_mounts_initrd.c):

Yes, this is unfortunate.

I personally still think that initrd should be removed.

I suggest using workaround I described in cover letter.

Also, for unknown reasons I didn't get your letter in my inbox.
(Not even in spam folder.) I ocasionally found it on lore.kernel.org .

-- 
Askar Safin

