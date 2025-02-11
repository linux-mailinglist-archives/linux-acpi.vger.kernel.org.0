Return-Path: <linux-acpi+bounces-10999-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063A6A303DF
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 07:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7751C1888AF7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 06:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765861E9B17;
	Tue, 11 Feb 2025 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uzQtafYl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613E1E9B05;
	Tue, 11 Feb 2025 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739256755; cv=none; b=ECUDRxWQjAq/ECAljgWTuzu4fBmeVVVQ2mZjUGVMlf5p7ab7dvKHUvoFmE7T84LDGxX+a1tXoxvcvWQPWtJ5gYFS1hMZhutoaespnxkzUGF5kMf9c/I4b2OcLIxsmS6eN+Wghv9zwm5nmVww7vkbRoPuPTP57QpBAL6tr3/lsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739256755; c=relaxed/simple;
	bh=GiDwWjf5cGNnmpmDE4al1V0wscsdaD7v2C2004KRKQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOmW1jujmUqHFBxSXgIdMzA+5DUJQcGAFTdMmbGGV8L3IzOb6wYmimk0UerjRWCh/JsSwktXDy5vXo3+AqyHt1GUXr246Ax3+9Nx7FC3q7AdDTN02pw6cNNGkON2f+bK/NYu686d94sbVOAL2xXQfYPBR1gtAmrbG8tUh0oF8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uzQtafYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E73C4CEDD;
	Tue, 11 Feb 2025 06:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739256754;
	bh=GiDwWjf5cGNnmpmDE4al1V0wscsdaD7v2C2004KRKQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzQtafYl+CZXSR+mSvlr7Ps4jdheLjp51HyGx8GB4vIdyp8moQ0oPWLyxLH7Vsmk6
	 CZtWUjYBeV62q9CJRvycFvhtw/D22EtwLAAmwBPFz70TxSm98aK0gwYoAhJOo4d98S
	 8cOm4BasXBz0tO4Rgm3ilRQagZHjfd8774L+eLWk=
Date: Tue, 11 Feb 2025 07:51:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ACPI/MRRM: Add "node" symlink to
 /sys/devices/system/memory/rangeX
Message-ID: <2025021111-deepen-landing-4252@gregkh>
References: <20250210211223.6139-1-tony.luck@intel.com>
 <20250210211223.6139-4-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210211223.6139-4-tony.luck@intel.com>

On Mon, Feb 10, 2025 at 01:12:22PM -0800, Tony Luck wrote:
> Users will likely want to know which node owns each memory range
> and which CPUs are local to the range.
> 
> Add a symlink to the node directory to provide both pieces of information.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/acpi/acpi_mrrm.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
> index 51ed9064e025..28b484943bbd 100644
> --- a/drivers/acpi/acpi_mrrm.c
> +++ b/drivers/acpi/acpi_mrrm.c
> @@ -119,6 +119,31 @@ static struct attribute *memory_range_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(memory_range);
>  
> +static __init int add_node_link(struct mrrm_mem_range_entry *entry)
> +{
> +	struct node *node = NULL;
> +	int ret = 0;
> +	int nid;
> +
> +	for_each_online_node(nid) {
> +		for (int z = 0; z < MAX_NR_ZONES; z++) {
> +			struct zone *zone = NODE_DATA(nid)->node_zones + z;
> +
> +			if (!populated_zone(zone))
> +				continue;
> +			if (zone_intersects(zone, PHYS_PFN(entry->base), PHYS_PFN(entry->length))) {
> +				node = node_devices[zone->node];
> +				goto found;
> +			}
> +		}
> +	}
> +found:
> +	if (node)
> +		ret = sysfs_create_link(&entry->dev.kobj, &node->dev.kobj, "node");

What is going to remove this symlink if the memory goes away?  Or do
these never get removed?

symlinks in sysfs created like this always worry me.  What is going to
use it?

thanks,

greg k-h

