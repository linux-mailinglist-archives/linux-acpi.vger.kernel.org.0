Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2E5749D00
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 15:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjGFNH7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 09:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjGFNH6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 09:07:58 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE661BD0;
        Thu,  6 Jul 2023 06:07:54 -0700 (PDT)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C3946C8;
        Thu,  6 Jul 2023 15:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1688648827;
        bh=mZejzzdjKlqQ2krw2Gv9daOUInxv4MAEstmm7L3+gpI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dCU3+d0u5QNGSdIF7oPbVtP2eOIlCnGS7fyCbrA2NfE0wkVNwjBsIomDn90oWfYSq
         Eyj4H5kQ54XEf48vdk8VsxZInNmDGp9/kRxrRKiBQQh2VQUFe3xcJkCGbHtIrhWw89
         XVdBEAeVw2OOh4bwZHB9DlK+UzUg5wI9gdyQUFmg=
Message-ID: <444bc344-ef72-6435-4638-bb4c8c23e5ee@ideasonboard.com>
Date:   Thu, 6 Jul 2023 14:07:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 01/18] media: ipu-bridge: Fix null pointer deref on
 SSDB/PLD parsing warnings
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Kate Hsuan <hpa@redhat.com>,
        Hao Yao <hao.yao@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
        linux-media@vger.kernel.org,
        =?UTF-8?Q?Fabian_W=c3=bcthrich?= <me@fabwu.ch>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-2-hdegoede@redhat.com>
Content-Language: en-US
From:   Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20230705213010.390849-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans

On 05/07/2023 22:29, Hans de Goede wrote:
> When ipu_bridge_parse_rotation() and ipu_bridge_parse_orientation() run
> sensor->adev is not set yet.
>
> So if either of the dev_warn() calls about unknown values are hit this
> will lead to a NULL pointer deref.
>
> Set sensor->adev earlier, with a borrowed ref to avoid making unrolling
> on errors harder, to fix this.
>
> Fixes: 485aa3df0dff ("media: ipu3-cio2: Parse sensor orientation and rotation")
> Cc: Fabian Wüthrich <me@fabwu.ch>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>


And same for the corresponding 09/18

>   drivers/media/pci/intel/ipu-bridge.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> index 62daa8c1f6b1..f0927f80184d 100644
> --- a/drivers/media/pci/intel/ipu-bridge.c
> +++ b/drivers/media/pci/intel/ipu-bridge.c
> @@ -308,6 +308,11 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
>   		}
>   
>   		sensor = &bridge->sensors[bridge->n_sensors];
> +		/*
> +		 * Borrow our adev ref to the sensor for now, on success
> +		 * acpi_dev_get(adev) is done further below.
> +		 */
> +		sensor->adev = adev;
>   
>   		ret = ipu_bridge_read_acpi_buffer(adev, "SSDB",
>   						  &sensor->ssdb,
