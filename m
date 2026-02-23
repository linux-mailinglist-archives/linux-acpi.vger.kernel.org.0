Return-Path: <linux-acpi+bounces-21073-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE/bJuyUnGnRJQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21073-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 18:57:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B4D17B2CB
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 18:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5DD7304C94B
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37B3339862;
	Mon, 23 Feb 2026 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFWyeOK2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1EA339866
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869228; cv=none; b=PnRVZFgglTcm9qFqZjqSGBBV3eEV6mRVuTUT7A/ZV2oLKyjTx//siKTajChDL3RQHx3uKJAxsipbJHzkyB/udoR32Y0ct7LmU1Ia4pifZA9eQi1LqQwRQBnD5AgKvZc9eWnxKyp8HwYAWvCGf2cakY48yj+VcoM7RUVF5BCw6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869228; c=relaxed/simple;
	bh=dD5OihsWQ7cuMdc/Bwdk5AKbu7MUQ+Q2mqg0J477YFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTW7fJjST3Wo0NG5p3en3es0Reb8Vv20edyHRlOFi95ynpkrEmgbcCz4NORMtkT7kNYoFspOS7qpAClUhqHnhYo3M5AVZODVmrmUhzTw4stEMDUUZB/5G9eKiH4Z3vG57R9yGgSG3VblYRKZu6wAEYx7ooLA98ZTXhErVSzwlzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFWyeOK2; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12721cd256bso5252768c88.1
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 09:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771869224; x=1772474024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=McVEYiWQKsUH8yffi2lamClhWSj5cXVz2XtqQUlFdkg=;
        b=WFWyeOK2nknodkNLQaYB2ntd1rMlx/njzAYVM3QRJyE5TJXlq2eQTZbBcxyqEypMt6
         c0bdDHlVwXAFWZW+eM4sx+MZcTGQcI+hxCXLzHFLTyLeX8TCNmvA9u0UAcVxuME/b8Yw
         eKR+miNe7vi2kaGCRvMFmKm+WJpIIwso8xcttVOj6Oar/Bm7OuGQGpCfpxNJuHcVGy5M
         12H9wb+kzaeO3+FZLpQmB9ukmdccniPwpgpHlOIc5oAdXtS9QzCdCOOzJP3N5TLoYdpw
         PaLVy9ThzCS3b4AvCc7HODxaBMkVEJ+CEk28zcajP82oiIOFOQBq8mZVfXBa2bAA7+6B
         6S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771869224; x=1772474024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McVEYiWQKsUH8yffi2lamClhWSj5cXVz2XtqQUlFdkg=;
        b=rJhCnYDGslicUYvixIkh69zD9aPS2i3D5Hzl6Wj5bgIBWc1/vrKEyEkR5X5hVDX9b/
         Qmj0z17YKHwz/5ICMd89vsb0p0DSleWDcqsuh5rjkCXcaTYdVrAw53SPvYarK18hKhNQ
         VcdEpgT/amqZ0Y8KtdW6BgjG/fdEPIrCVSfR4mne5JIF9E4m2lHPmT/YcEW3SZX8iQYc
         /RFLTDOr0SQMfd85umIxugD/1IHroPQkn2Vp9qBBD1ZMFT6pTqKLzt1JjPUhJrBA2zqv
         IQ/obnW4EYgC+90eJXLeDY4+JNbOfHfLKOvhA2YP71Ui6VWyGWG5v2HK/q67+Tfhj+xm
         VR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf/sWu3PC2+T5HA3esqbnAz7hvkRry9hxCxtItlqEPa6elPahhk/yYC7vKd1OgcSEE+KlfhEl3mlen@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQV7vQO7yY3N+JqSQEFvZuI+MWDxITY9RjkuXe/hvV3JU7sFN
	8YLTUv9KsXe4SFZmalOKRWtUJe25Kyk0ofY0DTHUB5H4uqglhuLHHdH8
X-Gm-Gg: AZuq6aJkxLVKi+ZB7sMlyAGv9rDddM81hc9k76DCeHEULh6WB3fgx7fejs/ijMAGLSG
	IweLlK/GRGxrPSISO0k3dafQatzJGU2TMoukw1g32hH1eeNU2Q5At1Na8C9iKNv730XEk67hrCA
	YnuQS0uoMIAqaVVH617x1guz6VA3Ovd/QmNc0dS2Rj3Ci0Tin35B5xOMAPPjtZg1GMgDG6AvQ5R
	MJk97BQz/PuVdZB9xzq9ngzCzdPsoHS6p1ttQ7rlVZbyAZfJslbxeoJGWPPT6P6xJuD+owBX/hT
	rjJtxxpXJzR2ZNyyzPQt2tdxF9gLo5w/H28517PZ3XNW873SjdWIMl8vJN5LOAhAls4Tk48ppqW
	8di+EIjWDxlO1QU8fUsgKoShNHHZxZpQvilmoGIOE06S1y8p0tu6MNpEIYxoE9VRpct2lsIjHFE
	cxp4xsqWtb8Jj2yYOp2chsFYQvC5g6ZvbmrapxFdFVtUvvl8jYCr3Co44I6JZmhDMQ
X-Received: by 2002:a05:7022:40f:b0:11f:2c9e:87f8 with SMTP id a92af1059eb24-1276ad4317emr4177636c88.34.1771869224454;
        Mon, 23 Feb 2026 09:53:44 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:1b48:5d6e:ab6e:5287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af20fc8sm9029506c88.6.2026.02.23.09.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:53:44 -0800 (PST)
Date: Mon, 23 Feb 2026 09:53:41 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] driver core: make fwnode_is_primary() public
Message-ID: <aZyTvZblnyMgDlYp@google.com>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-1-966c00c9eeeb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-device-match-secondary-fwnode-v2-1-966c00c9eeeb@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,linux.intel.com,gmail.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21073-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48B4D17B2CB
X-Rspamd-Action: no action

Hi Bartosz,

On Mon, Feb 23, 2026 at 04:40:52PM +0100, Bartosz Golaszewski wrote:
> Export fwnode_is_primary() in fwnode.h for use in driver code.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/base/core.c    | 5 -----
>  include/linux/fwnode.h | 5 +++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index f599a1384eec90c104601422b04dc2b4c19d4382..2e551bbe591b09c66b113b419ba63f17e8bea94a 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -5122,11 +5122,6 @@ int dev_warn_probe(const struct device *dev, int err, const char *fmt, ...)
>  }
>  EXPORT_SYMBOL_GPL(dev_warn_probe);
>  
> -static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> -{
> -	return fwnode && !IS_ERR(fwnode->secondary);
> -}
> -
>  /**
>   * set_primary_fwnode - Change the primary firmware node of a given device.
>   * @dev: Device to handle.
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 097be89487bf5c5a96f01d569c1691088db4f0ca..04db7f3ea50cceb9025c82c6449ba342d0e1b4a4 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -230,4 +230,9 @@ void fwnode_links_purge(struct fwnode_handle *fwnode);
>  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
>  bool fw_devlink_is_strict(void);
>  
> +static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> +{
> +	return fwnode && !IS_ERR(fwnode->secondary);
> +}

I think this is a bad API to be exported for wider use. It is surprising
that a standalone node is not considered to be a primary. It is also not
great that the argument is not constant pointer.

I would suggest having something like

bool fwnode_has_secondary(const struct fwnode_handle *fwnode);

Thanks.

-- 
Dmitry

