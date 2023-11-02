Return-Path: <linux-acpi+bounces-1146-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B302D7DEAB3
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 03:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BEA1C20DCD
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 02:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F87F1849
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ReltFv63"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78031ED8;
	Thu,  2 Nov 2023 00:51:57 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B88E8;
	Wed,  1 Nov 2023 17:51:52 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA29310A;
	Thu,  2 Nov 2023 01:51:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1698886294;
	bh=cnWSsDL7WnE8Db7zl/3EgRYszJPpFWDJcMvcapCjdnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ReltFv63lzk2CVH5drftDEioWJxMoONkLKV11tL1jELsxlAUM3s2jismq39rh8XYu
	 qu55vVfNFL6J5jxJWv1YLQtojZAGVVCktpGG0SY2nYch6oer81VyiyZqSkxdY8Zfn3
	 SEFe9f7v6/09d5SKK935fILjm10hlH9ChAwvceNU=
Date: Thu, 2 Nov 2023 02:51:56 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-media@vger.kernel.org,
	Paul Elder <paul.elder@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Julien Stephan <jstephan@baylibre.com>, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org, rafael@kernel.org
Subject: Re: [PATCH v2 1/1] device property: Add fwnode_name_eq()
Message-ID: <20231102005156.GA5933@pendragon.ideasonboard.com>
References: <20231101072729.1142578-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101072729.1142578-1-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Wed, Nov 01, 2023 at 09:27:29AM +0200, Sakari Ailus wrote:
> Add fwnode_name_eq() to implement the functionality of of_node_name_eq()
> on fwnode property API. The same convention of ending the comparison at
> '@' (besides '\0') is applied on also both ACPI and swnode. The function
> is intended for comparing unit address-less node names on DT and firmware
> or swnodes compliant with DT bindings.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> since v1:
> 
> - Use str_has_prefix().
> 
> - Fix kernel-doc for @fwnode argument.
> 
> - Use size_t type for len.
> 
> The patch is untested.

Not anymore :-)

Which tree will this get merged through ? The thp7312 driver depends on
this patch, and I would like to get it in v6.8. If we can merge this
through the media tree it could be the simplest option, otherwise I'll
need a stable branch based on v6.7-rc1.

>  drivers/base/property.c  | 28 ++++++++++++++++++++++++++++
>  include/linux/property.h |  1 +
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 8c40abed7852..89a6e0833356 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -594,6 +594,34 @@ const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
>  	return fwnode_call_ptr_op(fwnode, get_name_prefix);
>  }
>  
> +/**
> + * fwnode_name_eq - Return true if node name is equal
> + * @fwnode: The firmware node
> + * @name: The name to which to compare the node name
> + *
> + * Compare the name provided as an argument to the name of the node, stopping
> + * the comparison to either '\0' or '@' character, whichever comes first. This
> + * function is generally used for comparing node names while ignoring the
> + * possible unit address of the node.
> + *
> + * Return: true if the node name matches with the name provided in the @name
> + * argument, false otherwise.
> + */
> +bool fwnode_name_eq(const struct fwnode_handle *fwnode, const char *name)
> +{
> +	const char *node_name;
> +	size_t len;
> +
> +	node_name = fwnode_get_name(fwnode);
> +	if (!node_name)
> +		return false;
> +
> +	len = strchrnul(node_name, '@') - node_name;
> +
> +	return str_has_prefix(node_name, name) == len;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_name_eq);
> +
>  /**
>   * fwnode_get_parent - Return parent firwmare node
>   * @fwnode: Firmware whose parent is retrieved
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 083a1f41364b..096ade186601 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -108,6 +108,7 @@ struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
>  
>  const char *fwnode_get_name(const struct fwnode_handle *fwnode);
>  const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode);
> +bool fwnode_name_eq(const struct fwnode_handle *fwnode, const char *name);
>  
>  struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
>  struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode);

-- 
Regards,

Laurent Pinchart

