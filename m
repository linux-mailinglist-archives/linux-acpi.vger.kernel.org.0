Return-Path: <linux-acpi+bounces-19798-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 905AACD8670
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 08:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 903B63015130
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 07:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A25288522;
	Tue, 23 Dec 2025 07:40:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772D2673AA
	for <linux-acpi@vger.kernel.org>; Tue, 23 Dec 2025 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766475612; cv=none; b=eeGb2kdKcgKDT2NmBzVjYFtlWOcIEvA3pViFaxZV+2aCdUIlQQ+Z09tgfNcs07ba8Q2C/pbL/gq/o057v6bYKsj5axwOqBrG94LKjVvuTdYTpiMTFDxzkGuLPb9O3Vl080MbYMkSprEShNiNpISeLWAvkft4vlBqcA8NMInWRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766475612; c=relaxed/simple;
	bh=pfoqXMgUJnpcsP9gtPcdsMYzkDtZpzb3ZP/d7/KUILw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PER7RQoNw+lHdVlkHaqHdVmZw1ZfBSvGVSCiYWbmysbksantaLm31FOCp/zf2Xj0egciWgGE6UUB1uLjMjZvqb/sUyKpXe452+zmaWNBW57HImdguhoKgdKylufR2hKlx/Oi+YY0txtfC/81XrzbSHMhZ0UydAGMCRsw/UZ/x3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1766475553t425t50352
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.96.96])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 5829142609458046819
To: "'Bartosz Golaszewski'" <bartosz.golaszewski@linaro.org>
Cc: <andriy.shevchenko@linux.intel.com>,
	<andy@kernel.org>,
	<brgl@kernel.org>,
	<broonie@kernel.org>,
	<ckeepax@opensource.cirrus.com>,
	<dakr@kernel.org>,
	<david.rhodes@cirrus.com>,
	<djrscally@gmail.com>,
	<gregkh@linuxfoundation.org>,
	<heikki.krogerus@linux.intel.com>,
	<krzk@kernel.org>,
	<linus.walleij@linaro.org>,
	<linux-acpi@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-spi@vger.kernel.org>,
	<mstrozek@opensource.cirrus.com>,
	<p.zabel@pengutronix.de>,
	<patches@opensource.cirrus.com>,
	<rafael@kernel.org>,
	<rf@opensource.cirrus.com>,
	<sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v7 3/9] software node: allow referencing firmware nodes
Date: Tue, 23 Dec 2025 15:39:12 +0800
Message-ID: <02fd01dc73df$3b641bf0$b22c53d0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: Adxz28xSqTk+JEooSaWYdRA317rR+Q==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MPI5HzS7e4/KYQY34uIOdTCWQhxW6l4XZIal2CIyRJqKLx2ZSCJW9GN+
	e9WY4z0FAzE/gm67AVk7QOZkNXeJNlfnVTW+QPK2d24AeRlWgHYpCfiJ5PEaoJJIi8XwjY3
	5Ev5ctwUCvmAhcak5tw9oTM1DFGs1XlbUG2VLg18lQKFRkJwt5Tj6FC01Ga1csD+3pG7SMi
	zY/KNgTODfOTFkTHENU+HSVFgGhhNCva9bnkL5+EVgCsnKqSjBh1u7VpufQDaRA3yYtd7zu
	g2trxIEMSsPM6oELcZo7i5x87UjR9M3DccXdiHwqb1del94Ox2ANdwQRxNnSHO22swUm5qJ
	BXAuDvR7/LkQSI1/pZ2aaePGZgrq0pA/a8+civPOwiPGRDr9gJxySs1JXWTrelbeHiD7Mk8
	PRmSI7yHJeeJDd7uIDc42PWM4m3rAbIdiPr0/XWLtOsyERzMtIJ2bVd2D1EjtgQnk5ivpuJ
	irYiVqOhzO/xzH1CmD+LjoMhEyo3SMTBKEvr97V7ciVwbVrlORpGvneywbFqA1Z6pu0mfmm
	Z6a2ofsTba1Flq7+nKgCYe3jBbRsC6BqaTq4B58BwHaYgNC3VEWdqkr7DBGq3Mk/fROIOCa
	CxRTYsVul0MHE7XOuAf088bu+UMBgOe/Rl1uB6HPvrWKa/TmrueUXts3Q7J8VURcSWlWdur
	Tx7vjJ7LW16cgEpMr5tmUjMctxR/UIp6VcG2WXgphzCqsKYA4UmC9hz+yw0A9Yfi3zfTtJK
	ao64HFyBJmZFuVUVkXnh5RohPvxSzFLskIOzcROD0Mn0uau73aVPbJwVjZ5AKd1fKA/lN5h
	nA8hVoThGGBvJGYWJnd8eX8EaZlpBPNCI2PAqX9UTcPBZ+eL8xsCJyqwrh1PkLb8pye+wLK
	5zVTuryfVlLDZ1jEZxjxdgEaYYN5aX6K8udnN0TL8kZiK1oCV65HJaZN4B7XJsvSCUd0Vnt
	+jJa6ynkfS5nZpQzAUrF/Tjz/ISVrP45CyvjeSltRFAI2arDp2bsvVuPFW1+S14ByZlo=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Hi Bartosz Golaszewski,

> diff --git a/include/linux/property.h b/include/linux/property.h
> index 50b26589dd70d1..272bfbdea7bf4a 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -355,19 +355,26 @@ struct software_node;
>  
>  /**
>   * struct software_node_ref_args - Reference property with additional arguments
> - * @node: Reference to a software node
> + * @swnode: Reference to a software node
> + * @fwnode: Alternative reference to a firmware node handle
>   * @nargs: Number of elements in @args array
>   * @args: Integer arguments
>   */
>  struct software_node_ref_args {
> -	const struct software_node *node;
> +	const struct software_node *swnode;
> +	struct fwnode_handle *fwnode;
>  	unsigned int nargs;
>  	u64 args[NR_FWNODE_REFERENCE_ARGS];
>  };
>  
>  #define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
>  (const struct software_node_ref_args) {				\
> -	.node = _ref_,						\
> +	.swnode = _Generic(_ref_,				\
> +			   const struct software_node *: _ref_,	\
> +			   default: NULL),			\
> +	.fwnode = _Generic(_ref_,				\
> +			   struct fwnode_handle *: _ref_,	\
> +			   default: NULL),			\
>  	.nargs = COUNT_ARGS(__VA_ARGS__),			\
>  	.args = { __VA_ARGS__ },				\
>  }

This change seems incompatible with my driver txgbe, since the software nodes
are registered in " struct software_node * " but not " const struct software_node * ".

So when I pulled the net-next-6.19-rc1 that merged this patch, to probe my driver.
The error logs shows:
 
[    5.243396] txgbe 0000:10:00.0 (unnamed net_device) (uninitialized): unable to attach SFP bus: -EINVAL
[    5.243399] txgbe 0000:10:00.0: failed to init phylink
[    5.576008] txgbe 0000:10:00.0: probe with driver txgbe failed with error -22
[    6.109548] txgbe 0000:10:00.1 (unnamed net_device) (uninitialized): unable to attach SFP bus: -EINVAL
[    6.109551] txgbe 0000:10:00.1: failed to init phylink
[    6.442044] txgbe 0000:10:00.1: probe with driver txgbe failed with error -22
 


