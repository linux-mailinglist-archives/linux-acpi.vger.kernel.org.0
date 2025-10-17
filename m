Return-Path: <linux-acpi+bounces-17867-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A79FDBE8B9A
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 15:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2488D4FF076
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 13:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34EF331A4F;
	Fri, 17 Oct 2025 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b="K561RV6I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from manage.vyzra.com (unknown [104.128.60.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14883331A48
	for <linux-acpi@vger.kernel.org>; Fri, 17 Oct 2025 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.128.60.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706305; cv=none; b=B1hHqDbJUCakWOA5xj7O1C/0d8KylzfFHLzf6sFpBZbp3BPcFMSclqcqqQpsTZGdTBfYBvhs/HZZFa+QZU0G0//TMm+WR/Ul98fthL+3F1iQM4dFGU3tX2m1UQh2PCpxdGL1Yy7isrSjPMUQrUuJjDhuAqyyhQuq+8fEqbPnggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706305; c=relaxed/simple;
	bh=biLnUx9jTTyVdIbdiavoTAgEZeIqqOihfb373MH/e18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n7BfCzMcE5iPQNcubwsaFDPkEknaGsVDXmQb1LtYVs+MymkpFifqBiVGjpvzz6dRY44SbOiHPstHFM9ZNu2Z3wuEhfs4XmoxB6ghVrxWxvQ5zIBqDH2OcC3xxs6qADpUKHkLRzaP4b3Y7gP/cEVDEG/LQ+QE4JVwWTtlKTunFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org; spf=none smtp.mailfrom=manage.vyzra.com; dkim=fail (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b=K561RV6I reason="key not found in DNS"; arc=none smtp.client-ip=104.128.60.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=manage.vyzra.com
Received: from debtmanager.org (unknown [103.237.86.103])
	by manage.vyzra.com (Postfix) with ESMTPA id 4C47D4A8CFA4
	for <linux-acpi@vger.kernel.org>; Fri, 17 Oct 2025 07:45:31 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debtmanager.org;
	s=DKIM2021; t=1760705131; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Aj8bDacQlJB5qNMC5+yWWged1+K/M8YReXQkzUminbQ=;
	b=K561RV6IvmogC2Bw0+JyQRSkWU3dJFMYKwN1Anr8DbO0fEpvvp+S/A7hl3mJtc1H2NLCRL
	P7SnUgumtby+SZLgaCSWvr9Aq0CXAKgK6aph1lniPqyZEBl1UbqLgApGv+lIkP9FavfYC3
	/fuZreqGRwbwFs27SNv0eDuCxO/0ZFthRwFQBoM+jb4/X17S4UtUkchhYyuD2nq94E7kvy
	qbxmrRnE2uWhxSoZzpw2GSoHJckTnmmw31H6Ftgq3j6/pIDC8wL/iOUmntO1txLNBmEnuo
	6J2vG3UZTFVe0kcw/hoIkdegt6fDblMZfu/0KAD5hwjL0bi84+199tDa/2p2rQ==
Reply-To: vlad.dinu@rdslink.ro
From: "Vlad Dinu" <info@debtmanager.org>
To: linux-acpi@vger.kernel.org
Subject: *** Urgent Change ***
Date: 17 Oct 2025 05:45:30 -0700
Message-ID: <20251017054530.9C27B90258314616@debtmanager.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.10

Hello,

I am Vlad Dinu, the newly appointed Director of IMF Legal=20
Affairs, Security and Investigation. I have been given the=20
responsibility to look into all the payments that are still=20
pending and owed to fund beneficiaries / scam victims worldwide.

This action was taken because there have been issues with some=20
banks not being able to send or release money to the correct=20
beneficiary accounts. We have found out that some directors in=20
different organizations are moving pending funds to their own=20
chosen accounts instead of where they should go.

During my investigation, I discovered that an account was=20
reported to redirect your funds to a bank in Sweden.
The details of that account are provided below. I would like you=20
to confirm if you are aware of this new information, as we are=20
now planning to send the payment to the account mentioned.

NAME OF BENEFICIARY: ERIK KASPERSSON
BANK NAME: SWEDBANK AB
ADDRESS: REPSLAGAREGATAN 23A, 582 22 LINK=C3=96PING, SWEDEN
SWIFT CODE: SWEDSESS
ACCOUNT NUMBER: 84806-31282205


A payment instruction has been issued by the Department of=20
Treasury for an immediate release of your payment to the bank=20
account above without further prejudice. We cannot approve or=20
schedule payment to the 

given bank account without your confirmation. May we proceed with=20
the transfer to the Beneficiary: Erik Kaspersson, bank account in=20
Sweden?

I await your urgent response.

Mr. Vlad Dinu.

