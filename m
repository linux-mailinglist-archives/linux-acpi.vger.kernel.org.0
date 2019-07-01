Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C1D5B2C3
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2019 03:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfGABiB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 30 Jun 2019 21:38:01 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:52645 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfGABh7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Jun 2019 21:37:59 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190701013756epoutp04faf0510b9a1da3e4ce11b5bf9f833520~tJMWZubF42898228982epoutp04p
        for <linux-acpi@vger.kernel.org>; Mon,  1 Jul 2019 01:37:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190701013756epoutp04faf0510b9a1da3e4ce11b5bf9f833520~tJMWZubF42898228982epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561945076;
        bh=I6yDit6hDl9CUc82epoNHbW07NKafEsEnHWMJA3FK9o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QOtDhaS/+bqlbh6TIUQlRbgvW5/V4CgCilhvnzQNkoYWyPS826IjAraipuOUrAEFb
         d2AdkEl00VUZXfg1yJSFce7Gkjiv/fYpCVXpsbZqG/jVLf7yc1jnfl3efroJslK4Mi
         Ez4LraAe9k9GOK/w7cjXmp7JTSgZY0mmT8biFOM4=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190701013753epcas1p31b5728e396a67b8ea09b7c10dc9dccb4~tJMTcuWIi1608616086epcas1p3Z;
        Mon,  1 Jul 2019 01:37:53 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.C8.04143.BE3691D5; Mon,  1 Jul 2019 10:37:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190701013747epcas1p461980512af566420e1318c9d2d51e784~tJMN06tCG0332803328epcas1p4K;
        Mon,  1 Jul 2019 01:37:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190701013747epsmtrp2249004d149bc3c74e3d594ac9480ea13~tJMNz-p4_0833908339epsmtrp2W;
        Mon,  1 Jul 2019 01:37:47 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-7d-5d1963ebd05c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.1D.03692.BE3691D5; Mon,  1 Jul 2019 10:37:47 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190701013747epsmtip26605b414f56a5f0fdab066e06a41776f~tJMNmLaWX2446024460epsmtip2Y;
        Mon,  1 Jul 2019 01:37:47 +0000 (GMT)
Subject: Re: [PATCH 41/43] docs: extcon: convert it to ReST and move to acpi
 dir
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9abe1885-2252-82c3-caaa-1f7f09191399@samsung.com>
Date:   Mon, 1 Jul 2019 10:40:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <bce6d8c98a188ec5f0efe78962aa12839c7442e9.1561723980.git.mchehab+samsung@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmnu6bZMlYgw/fmCyeHGhntNj58C2b
        xfJ9/YwWC9uWsFhc3jWHzeL9p04mix2nFjFb3G5cwWZx5vQlVgdOj80rtDw2repk81jcN5nV
        Y8vVdhaPvi2rGD0+b5ILYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshL
        zE21VXLxCdB1y8wBOkpJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BZoFecmFtc
        mpeul5yfa2VoYGBkClSYkJ3RfU2qYKpSxdSPG5kaGJ9JdzFyckgImEicbH7C0sXIxSEksINR
        4sXqa4wQzidGiTP/f7FCON8YJT5P+84M0zL1/Qk2iMReRol3R9+zgiSEBN4zSjSd5wWxhQWC
        JBYf+cAGYosI5EjsXt/CDNLALNDEJDGt+SJYgk1AS2L/ixtgNr+AosTVH48ZQWxeATuJ6a/+
        MIHYLAIqEo+frmcBsUUFIiQub9kFVSMocXLmE7A4p0CixLKrR8DizALiEreezGeCsOUlmrfO
        BlssIdDOLvGudSoTxAsuEo8enWOBsIUlXh3fwg5hS0l8freXDcKullh58ggbRHMHo8SW/RdY
        IRLGEvuXTgYaxAG0QVNi/S59iLCixM7fc6GO4JN497WHFaREQoBXoqNNCKJEWeLyg7tQJ0hK
        LG7vZJvAqDQLyTuzkLwwC8kLsxCWLWBkWcUollpQnJueWmxYYIwc25sYwQlWy3wH44ZzPocY
        BTgYlXh4G+5IxAqxJpYVV+YeYpTgYFYS4Z17GCjEm5JYWZValB9fVJqTWnyI0RQY2hOZpUST
        84HJP68k3tDUyNjY2MLE0MzU0FBJnDee+2aMkEB6YklqdmpqQWoRTB8TB6dUA6NE2tGj9rcs
        9wb8mmic+0xT0WStjMFE03p2X8tVIvK7+Y8VX4hw31P5qXhB3T/hiu8vUtKdngV3s7NL7Ndc
        Zyt7RyP6ZN4vuZpderN8e0ss+i9JZ66/FbXvwcdNVgUTFh4K+SNeYJc7/TaXVNJurcQfu/x7
        Z/fKtt49nH3DpV/SduPx6NLnRUosxRmJhlrMRcWJANdbhDXGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSvO7rZMlYg43HVCyeHGhntNj58C2b
        xfJ9/YwWC9uWsFhc3jWHzeL9p04mix2nFjFb3G5cwWZx5vQlVgdOj80rtDw2repk81jcN5nV
        Y8vVdhaPvi2rGD0+b5ILYIvisklJzcksSy3St0vgyui+JlUwVali6seNTA2Mz6S7GDk5JARM
        JKa+P8HWxcjFISSwm1Hi4/Vp7BAJSYlpF48ydzFyANnCEocPF0PUvGWU+NHawwxSIywQJLH4
        yAc2EFtEIEei7dx3VpAiZoEWJollXXcZITpeMErM+P2GBaSKTUBLYv+LG2Ad/AKKEld/PGYE
        sXkF7CSmv/rDBGKzCKhIPH66HqxeVCBCoq9tNhtEjaDEyZlPwOKcAokSy64eAetlFlCX+DPv
        EjOELS5x68l8JghbXqJ562zmCYzCs5C0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjmpZbr
        FSfmFpfmpesl5+duYgTHmpbmDsbLS+IPMQpwMCrx8DbckYgVYk0sK67MPcQowcGsJMI79zBQ
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBsYc7Y8RE0rM
        2AUmcHctabViPG//kTv7/3QdrT0XdV8fXi6T/WSjypnAihcXN2jylDw7Nefctry+Y+ZVb492
        6YtsPn5fK7B9uY4um86SSpOTuZ8mzXvjOTevPsLxf9Eti4T7osU2MrsN+TYs7uxme/So+lbt
        RHWVcycOfM9T7Zvw4nPu3I95168qsRRnJBpqMRcVJwIAhz02vrECAAA=
X-CMS-MailID: 20190701013747epcas1p461980512af566420e1318c9d2d51e784
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190628122052epcas4p4a7ca381ae6c3bb7c83c09db3057728ec
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
        <CGME20190628122052epcas4p4a7ca381ae6c3bb7c83c09db3057728ec@epcas4p4.samsung.com>
        <bce6d8c98a188ec5f0efe78962aa12839c7442e9.1561723980.git.mchehab+samsung@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mauro,

On 19. 6. 28. 오후 9:20, Mauro Carvalho Chehab wrote:
> The intel-int3496.txt file is a documentation for an ACPI driver.
> 
> There's no reason to keep it on a separate directory.
> 
> So, instead of keeping it on some random location, move it
> to a sub-directory inside the ACPI documentation dir,
> renaming it to .rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
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
> index fd6fab0dec77..2cf8abf6d48e 100644
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
> @@ -4896,7 +4896,7 @@ S:	Maintained
>  F:	Documentation/
>  F:	scripts/kernel-doc
>  X:	Documentation/ABI/
> -X:	Documentation/acpi/
> +X:	Documentation/firmware-guide/acpi/
>  X:	Documentation/devicetree/
>  X:	Documentation/i2c/
>  X:	Documentation/media/
> @@ -6073,7 +6073,7 @@ S:	Maintained
>  F:	drivers/extcon/
>  F:	include/linux/extcon/
>  F:	include/linux/extcon.h
> -F:	Documentation/extcon/
> +F:	Documentation/firmware-guide/acpi/extcon-intel-int3496.rst
>  F:	Documentation/devicetree/bindings/extcon/
>  
>  EXYNOS DP DRIVER
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
