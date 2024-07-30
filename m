Return-Path: <linux-acpi+bounces-7131-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07673941F62
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B4A1F248B0
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F1118A6AB;
	Tue, 30 Jul 2024 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="BfvPq/d6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29A187FF9;
	Tue, 30 Jul 2024 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363533; cv=none; b=DM7UL1Uk9ohofYhMclvveZQoZaoeNvs2Zhrgfi+V/bTGnnAQ978eAOv1aXh7p3clQNczZa0DUpQH0DcLY7tg/SvZse9/tKSKAEniOw1lsyh0mJgLh5PbYg75dDiuT54AFdEvpsYw2qmpDvsJTWU5ceEhqF4FHR7BlTO0q1a277o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363533; c=relaxed/simple;
	bh=HlNdxc0Cjz172GnJ9aaT2a3Nq9FEmkCQ2qJkCCm7QdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kNnFZno9MUlATTDpt+taUj4XAre7kCUyPNSLHcFhMYOf/3UmJbaFXhgVpKaVpK79ZRm0BtEiNELi6vZ7PwY765v9jtTTzn8ShYNmIQnBcoboi0p6Wc4zeooNoytw9xvw7OastuMCRnvk7GB5bPPNgcCJ9KML0YQ5Jegt/MCGaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=BfvPq/d6 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 8afbd045dad971ee; Tue, 30 Jul 2024 20:18:48 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 77AD3956ED1;
	Tue, 30 Jul 2024 20:18:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722363528;
	bh=HlNdxc0Cjz172GnJ9aaT2a3Nq9FEmkCQ2qJkCCm7QdE=;
	h=From:To:Cc:Subject:Date;
	b=BfvPq/d6KZX8aAGRquaukZgOjfH06Qpy5se8l7JbJbTftCb472hMpW1VogHjxXamx
	 IzgglovUlf8HlaY/9A3kneS94lvXpGY0jafO1QWvnT4JCUm0aBUTqpjkhBh554F9mf
	 KBWhkotHyld/Xy7tm/k83Ybu79rH9KNfis9TMNUp932cazJByD7qHraYDmIvZ5RiuE
	 /JzD+GoG69uNN+IDTYlGWt98vPROUPFLIIU1HWlLX7VgUpIo+BNK0HqVnZ5chbktcJ
	 DiWr7qssg9JwLSltlh4y053pUJvH+IlRDfZ0SOMaemGiOl9ICxt2/ztYE+DsWRaIRu
	 nbTd61IMhne4g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 00/17] thermal: Rework binding cooling devices to trip points
Date: Tue, 30 Jul 2024 20:18:46 +0200
Message-ID: <5038376.0VBMTVartN@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
 phhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

Hi Everyone,

The code for binding cooling devices to trip points (and unbinding them from
trip point) is one of the murkiest pieces of the thermal subsystem.  It is
convoluted, bloated with unnecessary code doing questionable things, and it
works backwards.

The idea is to bind cooling devices to trip points in accordance with some
information known to the thermal zone owner (thermal driver).  This information
is not known to the thermal core when the thermal zone is registered, so the
driver needs to be involved, but instead of just asking the driver whether
or not the given cooling device should be bound to a given trip point, the
thermal core expects the driver to carry out all of the binding process
including calling functions specifically provided by the core for this
purpose which is cumbersome and counter-intuitive.

Because the driver has no information regarding the representation of the trip
points at the core level, it is forced to walk them (and it has to avoid some
locking traps while doing this), or it needs to make questionable assumptions
regarding the ordering of the trips in the core.  There are drivers doing both
these things.

But there's more.  The size of the binding/unbinding code can be reduced by
simply moving some parts of it around.  Some checks in it are overkill or
redundant.  White space is used inconsistently in it.  Its locking can be
made more straightforward.

Moreover, overhead can be reduced, especially in governors, if the lists of
thermal instances representing the bindings between cooling devices and trip
points are moved from thermal zone objects to trip descriptors.

The first 7 patches in the series deal with the minor issues listed above in
preparation for a more substantial change which is the introduction of a new
thermal operation, called .should_bind(), that will allow the core to do
exactly what it needs: as the driver whether or not the given cooling device
should be bound to a given trip, in patch [08/17].

Patch [09/17] makes the ACPI thermal driver use .should_bind() instead of
the .bind() and .unbind() operations which is a substantial simplification.

Patch [10/17] unexports two core functions previously used by the ACPI driver
that can be static now.

Patches [11-14/17] modify the remaining drivers implementing .bind() and
.undind() to use .should_bind() instead of them which results in significant
simplifications of the code.

The remaining 3 patches carry out cleanups that can be done after all of the
previous changes, resulting if further code size reductions.

Thanks!




