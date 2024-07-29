Return-Path: <linux-acpi+bounces-7109-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0498893F3C9
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 13:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71652B20F5D
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 11:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC2413EFEE;
	Mon, 29 Jul 2024 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2X4XCQf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95C2837B
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jul 2024 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251736; cv=none; b=sYMy8F73bjVaG7rQMfcuRY4rrytTHZ71WkumUpV59qSAGQOyz+oWVZocj3dMZSHcQb1e8L4RUBj6vc+nlZLT4ClFQDyvlAbuE/sVgIYXBQ/JLG4PIbywimV/oZh9I/yCFstC7cBrL1tHDcF6zqzEpgyYC0TXMXJzxQ/BJd6MdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251736; c=relaxed/simple;
	bh=E+PLCJ9yZEg5A6q0q7lw+rUF/kija8svyZwxz1HL8QM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WjszJ2F2xez/xu2A9aS0GhXiOGD3zm3Tz8ZR4/VVqdh/WCznFiOd4tMwNN9uqRZ4QOpaCwJ+5FyzxqLPQWjoaKfYLnFWQyVdGZNj+q1Sk5Qpj8hfXdOOw+dr/X6AeWnMKnfvJ9Pd7k7udqUk/fGXDcBorJx6d3Oaiea/2Wnvewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2X4XCQf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722251733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E+PLCJ9yZEg5A6q0q7lw+rUF/kija8svyZwxz1HL8QM=;
	b=C2X4XCQfqw2HhZ1HGOf959uQEDZlJnCQXEE9MS7ZnTwRZKGJZ3wwFyyWKaWTITrdf3QgUQ
	JGM0bJ/fOtDlm8Zfr9BdXJjcmnj2frOSUxRKXuan//HyCCp4dppr/ttnfvhAZOAev9HFTV
	LcjmdzrcsI5EoKkioZlpITmbRhCx1x8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-VaDtNPpKPoeakzVSWuvy-w-1; Mon, 29 Jul 2024 07:15:29 -0400
X-MC-Unique: VaDtNPpKPoeakzVSWuvy-w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3685e0df024so1467072f8f.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jul 2024 04:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722251726; x=1722856526;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+PLCJ9yZEg5A6q0q7lw+rUF/kija8svyZwxz1HL8QM=;
        b=UTj6v8ellKzUqohF96CahqGW0CDw7nEpxLhuBjQgcNzNahe+jvtKJx0wK0vA31XUOu
         jCaRUeZ7+6HOelJKVjGhinDCPJ2/I/6wugPBa8Vc1HzOQ6hctlBQPhdZWQOkNft5M6sB
         Inwl7vem8yzJjuanDTTVmH/4TjGkMUgNfF/2fbh3YsG5mKXwiQeryDn9ztNNBFutxIuj
         3I6S7IFAEiTkYoOdWnuQHVvSn9bKj0NnAVM9//vjCpFA8456Jt7MBewNx2VffIQwceVh
         5VkLjlXOkrGq76Yp2zubwFiHyS+lx8wrvJQxm1iVMibtgV02UfEd8G3+hWenPpiL+GOF
         GCgQ==
X-Gm-Message-State: AOJu0YxzI9Fs8bNkTFQw1MDLOHDDybTN6QulFWW3h9VGr74kQXUlCG6b
	U+2cqgyZ5j9GNDsv1Sixw0rHGxiI4Vq6zVe/ZoMdmWH6L5zra5LPuKMb7a7c4tqHHvEDsnH47xI
	ou5+pMVk9Ytlg/Oki2IYEK+OpPI7YycqDW/2XeIQADXS0QI43dQMFmQG4rwaj10OuZm0=
X-Received: by 2002:a5d:598b:0:b0:368:7e26:38d1 with SMTP id ffacd0b85a97d-36b5cee21fbmr6321946f8f.21.1722251725756;
        Mon, 29 Jul 2024 04:15:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVcJwHjxN83eTLxwGtjGZ46uMxi9PI8WLm7xLuQlgfKgkqmQEgbVyDsIFUNeKw20NDnNb3EA==
X-Received: by 2002:a5d:598b:0:b0:368:7e26:38d1 with SMTP id ffacd0b85a97d-36b5cee21fbmr6321917f8f.21.1722251725215;
        Mon, 29 Jul 2024 04:15:25 -0700 (PDT)
Received: from [172.18.228.53] (ip-185-104-138-47.ptr.icomera.net. [185.104.138.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0113sm11970104f8f.14.2024.07.29.04.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 04:15:24 -0700 (PDT)
Message-ID: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
Date: Mon, 29 Jul 2024 13:15:18 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Subject: "EC: Install address space handler at the namespace root" causing
 issues for some users
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rafael,

There are 2 bug reports:

1. Brightness up/down key-presses no longer working on LG laptop (acpi-video related):
https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/V2KWAGZIAX4TOWPCH6A6FSIT66PR3KMZ/

2. EC related ACPI errors and bad performance:
https://bugzilla.redhat.com/show_bug.cgi?id=2298938

Both of which started with 6.9.7 which has the 2 commits related to "EC: Install
address space handler at the namespace root" from 6.10 backported:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/acpi?h=v6.9.7&id=2b2b0ac1533d790690d6d28899f01a2924d54d4d
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/acpi?h=v6.9.7&id=9750135f2f326879889ed60ccd68b96572dfa6ee

i have build a test 6.9.9 kernel with these 2 reverted and 1. is confirmed to be fixed
by reverting these 2 commits. Although the user does report an IRQ storm on the ACPI IRQ
(IRQ 9) related to thunderbolt after this.

I have not yet got confirmation that the second bug is also resolved by the commits.

Either way it looks like we need to dig into this and figure out what is causing
these EC related regressions.

Regards,

Hans


