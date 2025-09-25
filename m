Return-Path: <linux-acpi+bounces-17301-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFB4B9DDB6
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 09:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842DD4A5A9A
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 07:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F061D8E1A;
	Thu, 25 Sep 2025 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="CQy/64Gd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD8D157A5A
	for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785493; cv=none; b=mZUNLC+mTL26ngGLZJh686ps9U0jLX33RbwXrIDYR0cFSY4/iJDyAAmp9XoHVc5bNbKSJ9KZ7ZQOlaV5VWNQlR+Xby/IN63iPTvuxJFqCQCUbO4loUnl+UoR4hVaBbIA5qd8ZWWqtIRoEjGdbYNMdbCNY/eeJg/X+M7Qz99MLVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785493; c=relaxed/simple;
	bh=LAeWxAX9hNeqInqdWNzekXI4thmR7vB+5nCfjOPRFR0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aj4f2v9Ht3Ixdg+6X8KPdbZPA2w3veY81AaBU9TfNiZt366KiBC/Ix1rqY1GcluDOdt4TfscYDWbzppXU3ObFPn2uE/LAgqB3s3gxpBzL10lufgGlxHIO2KA0EaSkzxZnovBSyWFajNQDbFWu/3zVT/kpvWEfYCtrPLu9pmHb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=CQy/64Gd; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.1/8.17.1.9) with ESMTPSA id 58P7CNjr010495
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 25 Sep 2025 09:12:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1758784345; bh=LAeWxAX9hNeqInqdWNzekXI4thmR7vB+5nCfjOPRFR0=;
	h=From:To:Subject:Date;
	b=CQy/64Gd1fm3KHW2bMw48c62JZlNN8WhDmbdLwKT0UhhUTMnX2h8X9GjIVe8nBcjk
	 hlnW7YXERM70v7rfQY/dqjcb5UA1DT9XiMFEfmXQQ4wju++x+Hp2k+oMlfJV6XBgIf
	 1EzAeK4UT6pC4phIjuEFzvXMs/KxGeOYQLpibTmY=
From: Dirk Gouders <dirk@gouders.net>
To: Borislav Deianov <borislav@users.sf.net>,
        Henrique de Moraes Holschuh
 <hmh@hmh.eng.br>,
        linux-acpi@vger.kernel.org
Subject: thinkpad_acpi: disagreement about versions
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 25 Sep 2025 09:12:18 +0200
Message-ID: <gh7bxn0zvx.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello,

after a longer time not using Zoom, I was asked to have a Zoom meeting
with some colleague and recognized, my mic isn't working (I'm using
Gentoo).

Chances are high, I'm doing something wrong with ALSA or PulseAudio.
These things usually just worked and I cannot preclude that I did
something wrong without noticing that I "killed" my mic.
But during the pandemic, I had several Zoom meetings and no problems --
with a recently replaced thinkpad, however.

I'm always running some recent kernel built from Linus' development
branch and now noticed these messages:

[    4.943230] thinkpad_acpi: disagrees about version of symbol snd_ctl_add
[    4.943235] thinkpad_acpi: Unknown symbol snd_ctl_add (err -22)
[    4.943243] thinkpad_acpi: disagrees about version of symbol snd_card_register
[    4.943246] thinkpad_acpi: Unknown symbol snd_card_register (err -22)
[    4.943249] thinkpad_acpi: disagrees about version of symbol snd_card_free
[    4.943252] thinkpad_acpi: Unknown symbol snd_card_free (err -22)
[    4.943310] thinkpad_acpi: disagrees about version of symbol snd_ctl_new1
[    4.943313] thinkpad_acpi: Unknown symbol snd_ctl_new1 (err -22)
[    4.943343] thinkpad_acpi: disagrees about version of symbol snd_card_new
[    4.943345] thinkpad_acpi: Unknown symbol snd_card_new (err -22)
[    4.943350] thinkpad_acpi: disagrees about version of symbol snd_ctl_boolean_mono_info
[    4.943352] thinkpad_acpi: Unknown symbol snd_ctl_boolean_mono_info (err -22)
[    4.943381] thinkpad_acpi: disagrees about version of symbol snd_ctl_notify
[    4.943383] thinkpad_acpi: Unknown symbol snd_ctl_notify (err -22)

I'm still gathering information and trying to get more understanding but
maybe someone could give me a hint where to look or to ask questions if
I don't get any further.

Thanks,

Dirk

