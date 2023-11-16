Return-Path: <linux-acpi+bounces-1568-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E6C7EE953
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 23:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0BCB209F3
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 22:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD6F46434
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owenh.net header.i=@owenh.net header.b="kDjPJbay"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B1393;
	Thu, 16 Nov 2023 14:16:01 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SWZ9m4dYjz9sqm;
	Thu, 16 Nov 2023 23:15:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owenh.net; s=MBO0001;
	t=1700172956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOs5PKValxWwrHSRlwT5CjuUgDsEUY/5qwCngDdQ3zg=;
	b=kDjPJbayGy0oHTuomMkZ0A2KY2B7z8B/c5Vox56YlXqprW5+e7r5R7svpnsbVR2dLLlUv8
	FefVqtlNtgGrpFVHC4UTcKW1V5Rl9vIluGSFS//ygN84udTaWyBycVB7By3XvnzTST2iM1
	FsR3JfL0hr6yKQXRFC2SrZEc2uuyskubLrGHNYPIy587BXn9FOOla7IKd473Y3mGP69KeQ
	VkjqhNeJzSwbfCPBh7IYsMNY/JUSpTAW19FBNWAo8EAhu71nivcmYIVrvqjnGEz8tC4V89
	zEbkVF4X+JiARv6Apgez/MKJVqGYdOMzeZePpjwKsG+fNLPIFZZLmsHpGkqR/g==
Message-ID: <2c23665d-7ba4-45f5-9065-76c58f6768b2@owenh.net>
Date: Thu, 16 Nov 2023 16:15:45 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION]: acpi/nouveau: Hardware unavailable upon resume or
 suspend fails
Content-Language: en-US
To: Hans de Goede <hdegoede@redhat.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown
 <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
References: <9f36fb06-64c4-4264-aaeb-4e1289e764c4@owenh.net>
 <CAAd53p7BSesx=a1igTohoSkxrW+Hq8O7ArONFCK7uoDi12-T4A@mail.gmail.com>
 <a592ce0c-64f0-477d-80fa-8f5a52ba29ea@redhat.com>
 <CAAd53p608qmC3pvz=F+y2UZ9O39f2aq-pE-1_He1j8PGQmM=tg@mail.gmail.com>
 <d1ac9c1e-f3fe-4d06-ba2e-2c049841d19b@owenh.net>
 <55698544-8cba-4413-bdd3-79cfaa1f3c44@redhat.com>
From: "Owen T. Heisler" <writer@owenh.net>
In-Reply-To: <55698544-8cba-4413-bdd3-79cfaa1f3c44@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4SWZ9m4dYjz9sqm

On 11/12/23 14:43, Hans de Goede wrote:
> Owen, Kai-Heng thank you for testing. I've submitted these patches
> to Rafael (the ACPI maintainer) now (with you on the Cc).
> Hopefully they will get merged soon.

That's great, thanks!

Owen


