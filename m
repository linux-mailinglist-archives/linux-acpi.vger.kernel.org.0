Return-Path: <linux-acpi+bounces-12185-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A53A5F37A
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 12:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750D23B7D7E
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 11:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8EB266B4B;
	Thu, 13 Mar 2025 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jQy7T0Aq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pYqsEwNo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jQy7T0Aq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pYqsEwNo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90964266B67
	for <linux-acpi@vger.kernel.org>; Thu, 13 Mar 2025 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866577; cv=none; b=p3sht4K+cDwHx54zWwPJnBuTOrxiEd3tZ5d5xWkFVlwMgq0If+/VZW9D8llRbjRyh0F4pOAGqAUkksc/CDwYYrYqy8h5iEe2S907P+rNsXLxSv/cJ8M0RprWm32irhnhy+KORRsYXEfb/4pt2wZsLv1keheqQXkwYFhoceRdk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866577; c=relaxed/simple;
	bh=ymVbr09/+0eQx25LnG7+hQQo99jgTHBhAsaViFfXSQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f11e1okcw9tkXU8ZxFq8Dy6AJCifE6XgLvIJJXnmsoEp+X1/cAPf8JrJvBO+CzE6rWkpONsXtjxtx9E7LQ4bOdaqpuUyUq2vBqhB7+zsjND/+fKmTVAf9rY+yt9n/cUoucYrxkvb/Zoz+0XL04ilU7ZrwXqvGjt1OxL+glNeD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jQy7T0Aq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pYqsEwNo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jQy7T0Aq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pYqsEwNo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76ECD21162;
	Thu, 13 Mar 2025 11:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741866573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yd8mYvTj9OAsmQlhNdKxRmv6VZmC7TaYNFRo1sXHwS4=;
	b=jQy7T0AqJzHjE/IrWInaqE/w92Sr5WcizvSyZ2neuI9vLuC/oXxOP6QlVvZ8I2wSuSjZVV
	thRebrTjHwiafOYzdmoARVGdhNwRbcS7x2Hl5pgOMSwX/JMSI65sOpwqBZt8vyI4SZfCeM
	BklrEOw7R+GmxQkiF18GBLTwUDLjq3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741866573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yd8mYvTj9OAsmQlhNdKxRmv6VZmC7TaYNFRo1sXHwS4=;
	b=pYqsEwNoQHU5tf/T7W6HxNI5BKSc1bp6tnZnczPGaecOi8p+sMx0zETbUdPeLSc4RhOQAT
	6TExC6t0uAMkcyBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741866573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yd8mYvTj9OAsmQlhNdKxRmv6VZmC7TaYNFRo1sXHwS4=;
	b=jQy7T0AqJzHjE/IrWInaqE/w92Sr5WcizvSyZ2neuI9vLuC/oXxOP6QlVvZ8I2wSuSjZVV
	thRebrTjHwiafOYzdmoARVGdhNwRbcS7x2Hl5pgOMSwX/JMSI65sOpwqBZt8vyI4SZfCeM
	BklrEOw7R+GmxQkiF18GBLTwUDLjq3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741866573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yd8mYvTj9OAsmQlhNdKxRmv6VZmC7TaYNFRo1sXHwS4=;
	b=pYqsEwNoQHU5tf/T7W6HxNI5BKSc1bp6tnZnczPGaecOi8p+sMx0zETbUdPeLSc4RhOQAT
	6TExC6t0uAMkcyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D31B137BA;
	Thu, 13 Mar 2025 11:49:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2UFpDU3G0mfcXgAAD6G6ig
	(envelope-from <jroedel@suse.de>); Thu, 13 Mar 2025 11:49:33 +0000
Date: Thu, 13 Mar 2025 12:49:23 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: New "something fishy here" warning fires
Message-ID: <Z9LGQ8h-I8c4igfr@suse.de>
References: <3046c6a2-72a0-412e-a865-48dc129be0df@gmail.com>
 <09bc17bd-4d25-4afd-8f6c-56707ea9bc92@linux.intel.com>
 <73e4c6fc-bc41-452b-8af5-9653436d8ba7@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73e4c6fc-bc41-452b-8af5-9653436d8ba7@arm.com>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,gmail.com,google.com,kernel.org,nvidia.com,vger.kernel.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,suse.com:url]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Mar 13, 2025 at 11:09:37AM +0000, Robin Murphy wrote:
> > The fix is here.
> > 
> > https://lore.kernel.org/linux- iommu/72a4853e7ef36e7c1c4ca171ed4ed8e1a463a61a.1741791691.git.robin.murphy@arm.com/
> 
> Indeed, and I see Joerg has updated the iommu/next branch already, so
> hopefully today's -next will be OK again. Sorry for the false positives!

Yes, the fix is part of iommu/next as of this (european) morning.

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany
https://www.suse.com/

Geschäftsführer: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)

