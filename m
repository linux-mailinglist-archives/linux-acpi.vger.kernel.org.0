Return-Path: <linux-acpi+bounces-21292-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDiuFMvRpGnJsQUAu9opvQ
	(envelope-from <linux-acpi+bounces-21292-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Mar 2026 00:54:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3211D1FD8
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Mar 2026 00:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 912AE300603F
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Mar 2026 23:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36A3002DC;
	Sun,  1 Mar 2026 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbEtHj1v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96019C553
	for <linux-acpi@vger.kernel.org>; Sun,  1 Mar 2026 23:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772409286; cv=none; b=ALRHOcUzVlEWmnWfs6hM8N7S/kDroekbAlMJRx1gs38+PNVbyXoCAvf1M5UidFtmg9/bpRG6z2Su6khsQg8JkYr338J/+uVLvxmhfT4sm8/4bmJ286mpv9505DgCwnZ0AkFnTHFUuWsnoPmheZMHg0/jmSwLGVA6ThFk680yh/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772409286; c=relaxed/simple;
	bh=rnNj0idF/E/fSfGyipXl8VHIBGr2hqUTrFeP3TUG7Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1G0jpr7prEp0mcfMhPJAs0xUHjTlY9yVbZO+g31EPCXlI6SzFpFsaeFLVRLtzxmSiOaVGng5S4UxiA6oHzBpoGwrCHRgp4g0SCWQ/BH/hTx+uXL2izxZUWhrpGpN/Sh3Zbupo+CeJYVcGiLqMuQHsdRdPxlHM0OWP8ALkO1XTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbEtHj1v; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bded9bf7a7so1913448eec.1
        for <linux-acpi@vger.kernel.org>; Sun, 01 Mar 2026 15:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772409284; x=1773014084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hovhJpml0URyC8GLPN7f58usjnnoeDS0ac1Oxzc6nXk=;
        b=HbEtHj1v91beOOs8sJ04IijMTnN0Gi/jml0jYLBEWRfj8a8/DOTDvo2mMfcC3Fj+9r
         ECLXv3zxoeWN8HiJrkU6I6u2w1rMOYBVXLpzFiLkXgGZBtYtG9DSIx7Ty66Ga/QkdUi6
         Jrk63CF0dp3i1Xl6cCyfkze2Ub1WBxMgd+YwSrAGdMV+KDwG2tDckxOvwFIvGp72GZEM
         2iQfaBVT3c9L9muiNpbgFVIIuk7o1Y4wFWY7evgeJGTdbqjs2jWqaKpxet/NT35yy04k
         cd6oYk+Z+LrpI2nCK8P+V3jc0yACH7mRychpUb8fSEvBzftfP6H8wB9b3MP93OcqDGk1
         epsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772409284; x=1773014084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hovhJpml0URyC8GLPN7f58usjnnoeDS0ac1Oxzc6nXk=;
        b=lkaouSTtSQiKtL3ln7NO+uC4QRJ8M+bbxLFVLu7Ry93mOMWBMN02/irApxJwfjJfKo
         E8pVQ1Hvy4XQKcJjuBThqLbYeRVn+yPeaU9Rp6gfXTR6kv2Hvy2QlnpXk3iZfdg/mBY5
         Rd6CPTfZVNrCf+YVDzfSUoP1Sf3Y6/gFwwFOCxdGi0nlAOaIM57pZxmXCzOdJCyIdrL6
         KIDZCmJtGgeG28G/V/WsCI1BTwHT3YfzU8QWelV8oLl24GLlBAr2aoDzoqwzR4tYLbZP
         suXgKmk7+q2gnaZ2DM5JcesAe6aE5DXWcFGA6ikm9Q3qyViohq1EM8iB7lMdQexvZey1
         s7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3jzRJAgBCPDvRexePMZIGpeM6l0JL0htvS8Lf5gvTUUobjMkEOC9Wu2fJwhR7AqvqM8PSkeEMJHoS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv++r+6htWriOHTxx386rveNVO0vK818ngpFVVs6m+K7XXjH+e
	wIRc7cmztPt7wrF9GsuUbxtoUSahMIINKuW3S9pfZAaxBgQphSE7zhGr
X-Gm-Gg: ATEYQzzhfXdSlvL42pb7l139/ppjk6UksirdmawlglqslS/FotuA6eoUR72GKdk8NrT
	aUauZWNy5IevCVHPHLTWkMmGGhQJgucFf5T1PTWJyn4n9eOA0nnuulBps4xQH5+CDb0TMjseW7T
	P+gbnOiIqqdCN15p5PemqMGgOyWC661+p+cSNXthdkKsMQOsRSmqXLG4VKYJJvrHaOm+B6oGF0d
	bZfpc9xAXRa1wnJn73EYCSc+TjPRmHbKps8EGhJmHLnwCmjoLf1kWwd/LmvXFfKisM4zjecO/Rq
	WLBpNym9rkDpIjoCMH5mfk3dGCVio95xyXDphRf5niLjkQejyqT7SBIIpbdLTCLDYbxO+vOzrF7
	2KD1cY+JTfsHq701S3wq0cXDhOGEOgRNRN8jYN+f/kV5ryALHPb+aVwbdmLQvj+aTpWWynhpejI
	71o4jNLutOWIc9h8s/rA5q0KIc0I8rttV3/aC2
X-Received: by 2002:a05:7300:730b:b0:2be:e92:7f43 with SMTP id 5a478bee46e88-2be0e928509mr643762eec.8.1772409284194;
        Sun, 01 Mar 2026 15:54:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdfed770d4sm3463985eec.17.2026.03.01.15.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 15:54:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 1 Mar 2026 15:54:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v1 2/3] hwmon: (acpi_power_meter) Register ACPI notify
 handler directly
Message-ID: <267b31e1-49ea-4f62-8893-9c5d2f187348@roeck-us.net>
References: <5974797.DvuYhMxLoT@rafael.j.wysocki>
 <2405555.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2405555.ElGaqSPkdT@rafael.j.wysocki>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21292-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,roeck-us.net:mid]
X-Rspamd-Queue-Id: 5C3211D1FD8
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 02:18:05PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> To facilitate subsequent conversion of the driver to a platform one,
> make it install an ACPI notify handler directly instead of using
> a .notify() callback in struct acpi_driver.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied.

Thanks,
Guenter

