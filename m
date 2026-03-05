Return-Path: <linux-acpi+bounces-21453-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCdcOr3nqWnuHQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21453-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:29:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A9A218273
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 617D130219CE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 20:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F3333A9FC;
	Thu,  5 Mar 2026 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+hnQCNI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275FE33A9C4;
	Thu,  5 Mar 2026 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742583; cv=none; b=YPXDNb5LMajp7OCxL2GHpz8KpcIr0r8aFDRqC+V6+qUgAx8M+QEUXGBUIa0j0LE6n1p240N5SdjzWAs93Kja4p0g2kBz/Ad7Ka8+caWX0bYzct8H2iCliIjWp7qVw+Nyp8rfKq3qiN7U9FeR1ME7RWAqJKo5BkAawBSEaRbnnWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742583; c=relaxed/simple;
	bh=nQcYCvZsqZtHFoA3zy5Q1JglIrlIyozYK4Gh4bACLJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E90W3BMycqmcoqUOHyKJ0jPU7HS21AUkPAe+kvFOJR5m5IgYsHMePah7Hj4iRe4CSu2r15NXWEgHc5DM6Z6jiI9j9n5gvk2pR5MLEw/KMJsG5ywqzOK9kxTEp5ojyJ1zfk7nJjo7/FTWrV8CzhAKcOger2hG2F5D67/XWefzPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+hnQCNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF9BC19422;
	Thu,  5 Mar 2026 20:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742582;
	bh=nQcYCvZsqZtHFoA3zy5Q1JglIrlIyozYK4Gh4bACLJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=X+hnQCNIyOKRLyEFTRlxtxdCR79MI+wYcce/y49RI9xBcY6wwQQzqoyToFpiLs5ol
	 M4f7TPzBMjeBMRb3CBI0GzTw6WWb3rb2uFONVLxux8QkWO/Mk7cXy9Tcq/fRFV6aq2
	 Mx+mlIsnN5UVPMGuzxInnaRr1fFYqFDg1LOfFGIAuwc2cg5RzIRg2W+zVNKewP13Z9
	 6d/+y4gi5SrSN7cGtozQjmInBvu6b9Q8XZhdVrv9wHg+QIbbU65TxuB2gNTBvqynRD
	 +sGMeRQYrTUQ12rYwicHsCB5NRdpxND+A3GKmh8Xfq7f8vuUct8mum7zbvv3PNNX2N
	 oJkHcE2pZ4cvA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject: [PATCH v1 0/9] ACPI: driver: Cleanups and fixes,
 mostly related to acpi_device_name/class()
Date: Thu, 05 Mar 2026 21:09:43 +0100
Message-ID: <4505861.ejJDZkT8p0@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C6A9A218273
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21453-lists,linux-acpi=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi All,

This series 

 * Cleans up a few wonky things in the core ACPI drivers (patches [1-4/9])
 * Updates several drivers to stop setting acpi_device_name(), which
   is not used anywhere later (patch [5/9])
 * Adjusts notification APIs to be more consistent and in preparation for
   the next change (patch [6-7/9])
 * Updates several drivers to stop setting acpi_device_class(), which is not
   used anywhere later, and one driver still using it (button) to clear it
   on remove (patch [8/9])
 * Consolidates the ACPI_AC_CLASS definitions (patch [9/9]).

Thanks!




