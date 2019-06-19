Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F114B5B8
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2019 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfFSJ7Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Jun 2019 05:59:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60470 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731178AbfFSJ7V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jun 2019 05:59:21 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id a564063612c784c5; Wed, 19 Jun 2019 11:59:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 20/22] docs: extcon: move it to acpi dir and convert it to ReST
Date:   Wed, 19 Jun 2019 11:59:18 +0200
Message-ID: <4701210.Ilfu9VLqBR@kreacher>
In-Reply-To: <b6d199c3e7c8c868acbb313a1a516ea8aed042ee.1560891322.git.mchehab+samsung@kernel.org>
References: <cover.1560891322.git.mchehab+samsung@kernel.org> <b6d199c3e7c8c868acbb313a1a516ea8aed042ee.1560891322.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, June 18, 2019 11:05:44 PM CEST Mauro Carvalho Chehab wrote:
> The intel-int3496.txt file is a documentation for an ACPI driver.
> 
> There's no reason to keep it on a separate directory.
> 
> So, instead of keeping it on some random location, move it
> to a sub-directory inside the ACPI documentation dir.
> 
> For now, keep it with .txt extension, in order to avoid
> Sphinx build noise. A later patch should change it to .rst
> and movin it to be together with other acpi docs.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or please let me know if you want me to pick up this one.

> ---
>  .../acpi/extcon-intel-int3496.rst}                 | 14 ++++++++++----
>  Documentation/firmware-guide/acpi/index.rst        |  1 +
>  MAINTAINERS                                        |  6 +++---
>  3 files changed, 14 insertions(+), 7 deletions(-)
>  rename Documentation/{extcon/intel-int3496.txt => firmware-guide/acpi/extcon-intel-int3496.rst} (66%)
> 
> diff --git a/Documentation/extcon/intel-int3496.txt b/Documentation/firmware-guide/acpi/extcon-intel-int3496.rst
> similarity index 66%
> rename from Documentation/extcon/intel-int3496.txt
> rename to Documentation/firmware-guide/acpi/extcon-intel-int3496.rst
> index 8155dbc7fad3..5137ca834b54 100644
> --- a/Documentation/extcon/intel-int3496.txt
> +++ b/Documentation/firmware-guide/acpi/extcon-intel-int3496.rst
> @@ -1,5 +1,6 @@
> +=====================================================
>  Intel INT3496 ACPI device extcon driver documentation
> ------------------------------------------------------
> +=====================================================
>  
>  The Intel INT3496 ACPI device extcon driver is a driver for ACPI
>  devices with an acpi-id of INT3496, such as found for example on
> @@ -13,15 +14,20 @@ between an USB host and an USB peripheral controller.
>  The ACPI devices exposes this functionality by returning an array with up
>  to 3 gpio descriptors from its ACPI _CRS (Current Resource Settings) call:
>  
> -Index 0: The input gpio for the id-pin, this is always present and valid
> -Index 1: The output gpio for enabling Vbus output from the device to the otg
> +=======  =====================================================================
> +Index 0  The input gpio for the id-pin, this is always present and valid
> +Index 1  The output gpio for enabling Vbus output from the device to the otg
>           port, write 1 to enable the Vbus output (this gpio descriptor may
>           be absent or invalid)
> -Index 2: The output gpio for muxing of the data pins between the USB host and
> +Index 2  The output gpio for muxing of the data pins between the USB host and
>           the USB peripheral controller, write 1 to mux to the peripheral
>           controller
> +=======  =====================================================================
>  
>  There is a mapping between indices and GPIO connection IDs as follows
> +
> +	======= =======
>  	id	index 0
>  	vbus	index 1
>  	mux	index 2
> +	======= =======
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index ae609eec4679..90c90d42d9ad 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -24,3 +24,4 @@ ACPI Support
>     acpi-lid
>     lpit
>     video_extension
> +   extcon-intel-int3496
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e07cbd44d48a..b7c81bd0f8e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -321,7 +321,7 @@ F:	drivers/pnp/pnpacpi/
>  F:	include/linux/acpi.h
>  F:	include/linux/fwnode.h
>  F:	include/acpi/
> -F:	Documentation/acpi/
> +F:	Documentation/firmware-guide/acpi/
>  F:	Documentation/ABI/testing/sysfs-bus-acpi
>  F:	Documentation/ABI/testing/configfs-acpi
>  F:	drivers/pci/*acpi*
> @@ -4881,7 +4881,7 @@ S:	Maintained
>  F:	Documentation/
>  F:	scripts/kernel-doc
>  X:	Documentation/ABI/
> -X:	Documentation/acpi/
> +X:	Documentation/firmware-guide/acpi/
>  X:	Documentation/devicetree/
>  X:	Documentation/i2c/
>  X:	Documentation/media/
> @@ -6057,7 +6057,7 @@ S:	Maintained
>  F:	drivers/extcon/
>  F:	include/linux/extcon/
>  F:	include/linux/extcon.h
> -F:	Documentation/extcon/
> +F:	Documentation/firmware-guide/acpi/extcon-intel-int3496.rst
>  F:	Documentation/devicetree/bindings/extcon/
>  
>  EXYNOS DP DRIVER
> 




