Return-Path: <linux-acpi+bounces-21049-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMIqKAKPm2lN2AMAu9opvQ
	(envelope-from <linux-acpi+bounces-21049-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 00:19:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D4170B98
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 00:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CDC1300F122
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Feb 2026 23:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393A4353EC0;
	Sun, 22 Feb 2026 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moFamt4L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14793221D89;
	Sun, 22 Feb 2026 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771802366; cv=none; b=Iw3jze6gOPWrj7HJE0LMBC/H96YMkJ9l6rK/OBIf4+0S3SSTy5aX12r0GpPvdmabNI3O2O39DNT/BsODTzn1OWkPwwM4jAos7eKwk5JIDZCwlawxup/pF972TDtyJbXDIHgYog4i/V9YeUKOKZCk/8dGyKpMvrAhhlPODg4/fQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771802366; c=relaxed/simple;
	bh=1Jr2UFYlqfUbVcRlaHdvfopn8D6VYXN8wRPR+OoZSDY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=PurRzkbbuBmssOkXItpkC9X2df8xqAS1K3Cgbc/srPhjM5fqaSXFuN8eIV4FOuHdlSnyADPdWcj8TY8oLBTbsELMgxL5xhKHgIw5lf8cOHip31/TMLG++Y5F9SHh1bN25fOgN86LyrHNs2827qrG5u3RmwgLOcKtqGZCNDDJeDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moFamt4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7FCC116D0;
	Sun, 22 Feb 2026 23:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771802365;
	bh=1Jr2UFYlqfUbVcRlaHdvfopn8D6VYXN8wRPR+OoZSDY=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=moFamt4LVHii95rcJwIond6Bv6oxAYIMUstt1M01IICrGmNdAahQIU6nMdQeEpxRy
	 9qCFrqX1p273BZ4O2039IwLn0osoHQOphZB2bFUqbk0ylUANlNS237t7kP+aWhy+Zk
	 V1fs3xaSGDG8TaNSBsU3yL8B/O0Y50vSERomdHBM2zN5JGLBo411Y0R/toiU8pg1Kj
	 EQT7ZzeBbvuxrOBkIlMzycBzt7hjq2pEL3DUaDS8s7NbVGHZgRMKVa7KaapZj3cA7q
	 180zUDR78dOOna5w4X3GxwIMgMYIsWT9YIIhtqKbPmaVapiXhVfEtC5zCcECwOMfC1
	 z5xjMbhwNC8Cw==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 00:19:21 +0100
Message-Id: <DGLVIO9YF9PK.1WM118M9OSS0N@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v1 1/1] device property: Allow secondary lookup in
 fwnode_get_next_child_node()
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Daniel
 Scally" <djrscally@gmail.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <stable@vger.kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
References: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21049-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.intel.com,linuxfoundation.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-acpi@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: EF5D4170B98
X-Rspamd-Action: no action

On Tue Feb 10, 2026 at 2:58 PM CET, Andy Shevchenko wrote:
> When device_get_child_node_count() got split to the fwnode and device
> respective APIs, the fwnode didn't inherit the ability to traverse over
> the secondary fwnode. Hence any user, that switches from device to fwnode
> API misses this feature. In particular, this was revealed by the commit
> 1490cbb9dbfd ("device property: Split fwnode_get_child_node_count()")
> that effectively broke the GPIO enumeration on Intel Galileo boards.
> Fix this by moving the secondary lookup from device to fwnode API.
>
> Note, in general no device_*() API should go into the depth of the fwnode
> implementation.
>
> Fixes: 114dbb4fa7c4 ("drivers property: When no children in primary, try =
secondary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to driver-core-linus, thanks!

