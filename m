Return-Path: <linux-acpi+bounces-21514-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CkzJJ/8XrGn7kQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21514-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 07 Mar 2026 13:20:15 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0244022BAAA
	for <lists+linux-acpi@lfdr.de>; Sat, 07 Mar 2026 13:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 789D0301C934
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Mar 2026 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D0C337BA0;
	Sat,  7 Mar 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cetPOPQ0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920372DC35C;
	Sat,  7 Mar 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772886011; cv=none; b=TR4fi8bgz+akttb+WttJMJz490HSPo+/wSNpeVBvyfsrXDZZ2Zg/pZLZ9vevPFm20/lmAgAmx9pe+u9xPMRuzWdThuw1mQCdK400NAL9gc5z6CoN4VsfgXE/fnYizuVjvjkrQSfo1x/nZjRiAuiKh/dUrytDCBlXDvLU9Zjen6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772886011; c=relaxed/simple;
	bh=jiRi92ztOe93ijqJqbf1JgES37OuCVHNCdB1G3L9DHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0zPo/+G4drnKandwVssxMkJdpaxRPrQDuLyuVSJstzeKe5ealyDuLPBYHsyWeinOmss4GbgN/m6dQ8gmwZjX8cc/2HAJkBAZbYm4nlMxMCToNe2QnKwCZLAslAX8CvbamQKahrdY0Aueh7lubLyquzMbGbMRwLpafEMqvzH4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cetPOPQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF33C19422;
	Sat,  7 Mar 2026 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772886011;
	bh=jiRi92ztOe93ijqJqbf1JgES37OuCVHNCdB1G3L9DHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cetPOPQ0ZNK4yOirBNPB69Ea2YnkkhQaB+fPZVxot6FHiv+u2MVOjF5N1Kda+amYg
	 /R/K8smNfGCQfpzhh+Xj5ADcrHx4+uEkSlTzNcqlZWL70kiRjYWq4/WvbRsjZ6AQRe
	 b6t5ENr22YsBM4pXX+iQphHJKdKQuJ9UJAbfcsyFfTzl0kH4y117HYfTq5Kan0h92P
	 RAs2mI/Tqu/QyHNnNAD492ituRYJyWAYrm6yyViRCG08nEhZ7g+kBtJ2A0f2ZLaR/0
	 1cHtUtp61DoMXM+YCiLi7xmqG7BqAtuQipzN8wYAdhkZ127/envQnxNq7ykkQlUt+Q
	 YX22ldal9FO0w==
Date: Sat, 7 Mar 2026 12:20:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: light: acpi-als: Convert ACPI driver to a
 platform one
Message-ID: <20260307122003.691e2478@jic23-huawei>
In-Reply-To: <aakseadAuKEMAmvq@ashevche-desk.local>
References: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
	<3609079.QJadu78ljV@rafael.j.wysocki>
	<aakseadAuKEMAmvq@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0244022BAAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21514-lists,linux-acpi=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.939];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

On Thu, 5 Mar 2026 09:10:49 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Mar 04, 2026 at 07:33:14PM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > 
> > In all cases in which a struct acpi_driver is used for binding a driver
> > to an ACPI device object, a corresponding platform device is created by
> > the ACPI core and that device is regarded as a proper representation of
> > underlying hardware.  Accordingly, a struct platform_driver should be
> > used by driver code to bind to that device.  There are multiple reasons
> > why drivers should not bind directly to ACPI device objects [1].
> > 
> > Overall, it is better to bind drivers to platform devices than to their
> > ACPI companions, so convert the ACPI ambient light sensor driver to a
> > platform one.
> > 
> > After this change, the subordinate IIO device will be registered under
> > the platform device used for driver binding instead of its ACPI
> > companion.
> > 
> > While this is not expected to alter functionality, it changes sysfs
> > layout and so it will be visible to user space.  
> 
> ...
> 
> > -static struct acpi_driver acpi_als_driver = {
> > -	.name	= "acpi_als",
> > -	.class	= ACPI_ALS_CLASS,
> > -	.ids	= acpi_als_device_ids,
> > -	.ops = {
> > -		.add	= acpi_als_add,
> > -		.remove	= acpi_als_remove,
> > +static struct platform_driver acpi_als_driver = {
> > +	.probe = acpi_als_probe,
> > +	.remove = acpi_als_remove,
> > +	.driver = {
> > +		.name = "acpi_als",
> > +		.acpi_match_table = acpi_als_device_ids,
> >  	},
> >  };  
> 
> >    
> 
> You can also drop this unneeded blank line.
> 
> > -module_acpi_driver(acpi_als_driver);
> > +module_platform_driver(acpi_als_driver);  
> 
> Anyways, LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tweaked and applied to the testing branch of iio.git.

Thanks,

Jonathan

> 


