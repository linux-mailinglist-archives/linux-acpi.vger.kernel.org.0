Return-Path: <linux-acpi+bounces-7535-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E38394EDE0
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 15:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EFA1F22212
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C274E17C23D;
	Mon, 12 Aug 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="TDQYbg2d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC2217B4FF;
	Mon, 12 Aug 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468612; cv=none; b=OReWdhOw2FtwsObqwXkz+0Y1tDI/xC0buEB7HLy7GAkZSrrW9wRCB58GhXnQXhj6MUS2+ovKQJolV8ogeXkCXP3tby550gHKRmo7ymgW9AboKsxxr7vqCJHhWlnrUCk+sX8k9d82qhAfOw5aMCz2z0Y7e2NC3WvCPm5+mAuqf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468612; c=relaxed/simple;
	bh=BGm2PbujCguLHeHHgKMA+VzqhJ/SanUwau8vAYH+7Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KA/zCcKKQleyu267g3wyywI+wZ3mT8l7RpB7kyT3CXBfquLHd2eEFRLCC8bTTpkEQQ8BDbQu2mG7pxzrFze4QqSJDw43EAc5Ruop2JAj7mCLuTV1mfXzBfqEoOHDHWePilaJn1jKcT2CS8qchK2W+KK6bNifj6XYoFyaEnDpHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=TDQYbg2d reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 209b57da2e2ac86b; Mon, 12 Aug 2024 15:16:48 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 478306F0D95;
	Mon, 12 Aug 2024 15:16:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723468608;
	bh=BGm2PbujCguLHeHHgKMA+VzqhJ/SanUwau8vAYH+7Wg=;
	h=From:Subject:Date;
	b=TDQYbg2dQVRlNcsLZXzI0qbu/6/kUjLnl/bE0uB5+sbWExpyigEaqcBPIjTSaEawd
	 sfiFmUt4sR660TljCQkoVsRjS9kdevf2QKlV7BJ9xIE82rsLBbXutYGHP5NadizR62
	 9Vo4DVAt4u3MruFBRAJDTdYBnPkeMIoXxXDVIwmmfNGGs5Y8VXpQVAwp+DeTHW0Nci
	 yAEXT2zUVpZDjytHtDvgOqsp1S1ZwcSwd12RfUGS+OkJubIISlg0q6VUtxDcTpL5Z1
	 d/KVo/baxdiUpyhBfZj2kWMiVy4aTjitEYwbHkC4jecNomdw6IK7fMrTzOmt37x5ok
	 giJvxzHCyBjPQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 0/3] ACPI: EC: Avoid evaluating _REG for non-functional operation
 regions
Date: Mon, 12 Aug 2024 15:06:25 +0200
Message-ID: <22385894.EfDdHjke4D@rjwysocki.net>
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
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhg
 pdhrtghpthhtohepfigprghrmhhinhesghhmgidruggv
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

The purpose of this series is to address issues reported here:

https://lore.kernel.org/linux-acpi/1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com/

and related to evaluating _REG for EC operation regions that are not
expected to be used (for example, because they reside in the scopes of
ACPI device objects whose _STA returns 0).

The first patch reverts commit 0e6b6dedf168 ("Revert "ACPI: EC: Evaluate orphan
_REG under EC device") that will not be necessary after making the changes in
the last patch.  The second patch modifies acpi_execute_reg_methods() to take
an additional "depth" argument that will be needed doing forward.

The last patch moves the _REG evaluation for EC operation regions beyond the
EC device scope to acpi_bus_attach() so it is only evaluated if the device
object holding the EC operation region is present.

Thanks!




