Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7240A8F1
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Sep 2021 10:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhINIMv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Sep 2021 04:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhINIMu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Sep 2021 04:12:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED4FF60EB6;
        Tue, 14 Sep 2021 08:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631607093;
        bh=XgV0VOwvYlmpCGt57z0PpVVIaNEuFhMTiNswnTjNPNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+2g4OFaI37lXcjPLJCQ+0laA6wruiudyCf/zFuxrhhSCpwWDxenL6rtAWeDR6OwP
         qoM4EnRUWdvuX/xPQVORsc348Aooa0WKhnfCu0wUh0VydPo8LkaRn4DlvFPrhAovn1
         uuybODtnhmLh9kjflC5slScmpz3iKy7a7WtBKNTo=
Date:   Tue, 14 Sep 2021 10:11:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alexander Graf <graf@amazon.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/5] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <YUBZM1vnZ3LjfUKc@kroah.com>
References: <cover.1631600169.git.yu.c.chen@intel.com>
 <7a739633b30f6fb5c258f21c443ed0c17b12896f.1631600169.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a739633b30f6fb5c258f21c443ed0c17b12896f.1631600169.git.yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 14, 2021 at 03:58:41PM +0800, Chen Yu wrote:
> +enum start_action {
> +	START_STAGE,
> +	START_ACTIVATE,
> +	START_STAGE_ACTIVATE,
> +};
> +
> +enum dsm_status {
> +	DSM_SUCCEED,
> +	DSM_FUNC_NOT_SUPPORT,
> +	DSM_INVAL_INPUT,
> +	DSM_HARDWARE_ERR,
> +	DSM_RETRY_SUGGESTED,
> +	DSM_UNKNOWN,
> +	DSM_FUNC_SPEC_ERR,
> +};
> +
> +struct update_cap_info {
> +	enum dsm_status status;
> +	int update_cap;
> +
> +	uuid_t code_type;
> +	int fw_version;
> +	int code_rt_version;
> +
> +	uuid_t drv_type;
> +	int drv_rt_version;
> +	int drv_svn;
> +
> +	uuid_t platform_id;
> +	uuid_t oem_id;
> +
> +	char oem_info[];

Please use valid types for structures that cross the user/kernel
boundry.

> +};
> +
> +struct com_buf_info {
> +	enum dsm_status status;
> +	enum dsm_status ext_status;
> +	unsigned long addr_lo;
> +	unsigned long addr_hi;
> +	int buf_size;
> +};

Same here.

> +
> +struct updated_result {
> +	enum dsm_status status;
> +	enum dsm_status ext_status;
> +	unsigned long low_auth_time;
> +	unsigned long high_auth_time;
> +	unsigned long low_exec_time;
> +	unsigned long high_exec_time;

And same here.

And these are very odd structure names that you are adding to the
"global" namespace.  Please make them have a prefix for your driver so
that people know what they belong to.  "updated_result" is way too
generic.

thanks,

greg k-h
