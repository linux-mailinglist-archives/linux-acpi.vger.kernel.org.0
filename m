Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88E8106D7
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2019 12:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEAKNQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 May 2019 06:13:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41884 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfEAKNP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 May 2019 06:13:15 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 80415e515d2687d5; Wed, 1 May 2019 12:13:13 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH next 01/25] ACPI / DPTF: Use dev_get_drvdata()
Date:   Wed, 01 May 2019 12:13:13 +0200
Message-ID: <1630516.6fPAFj0BIz@kreacher>
In-Reply-To: <20190423075020.173734-2-wangkefeng.wang@huawei.com>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com> <20190423075020.173734-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, April 23, 2019 9:49:56 AM CEST Kefeng Wang wrote:
> Using dev_get_drvdata directly.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/acpi/dptf/dptf_power.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
> index e1c242568341..0c081390930a 100644
> --- a/drivers/acpi/dptf/dptf_power.c
> +++ b/drivers/acpi/dptf/dptf_power.c
> @@ -31,8 +31,7 @@ static ssize_t name##_show(struct device *dev,\
>  			   struct device_attribute *attr,\
>  			   char *buf)\
>  {\
> -	struct platform_device *pdev = to_platform_device(dev);\
> -	struct acpi_device *acpi_dev = platform_get_drvdata(pdev);\
> +	struct acpi_device *acpi_dev = dev_get_drvdata(dev);\
>  	unsigned long long val;\
>  	acpi_status status;\
>  \
> 

Applied, thanks!




