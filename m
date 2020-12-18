Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F382A2DEC2F
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Dec 2020 00:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgLRX6i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 18:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgLRX6i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2020 18:58:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E10C0617B0;
        Fri, 18 Dec 2020 15:57:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r3so4297181wrt.2;
        Fri, 18 Dec 2020 15:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tvXl0W+WJwpnbxy3THEOQYack8Z4j8OQae2L4gnwAYw=;
        b=d6Yu7BK1W77mwLSclcTkOVuwCLsCfbArAxi+vbGYgWSFLLfRZXlcBrpQX625dCxoBc
         rWL1oxv2Su1YmDyaBEzWxKGg/beqMhojBnuOBA8eInfeQ+mtebSrtc08LjH6V9ozx4Tt
         gvnn7Num4KpNVxZqZLhQtqTjqjZ5ngP6BTkkNfrShmk5r2GCLBXHaRNH/3GgFHbKsWIl
         6v4KhwqLGXUy8TKPgN+ZfREFMnVVxZx8gYuaaojaqcfRDnG39Xz6cuWuKCkxPHuT0k1B
         7VLhqTfAqIGV30njvbz54MUGVHueyBYJb9HIwMhrUAlxODtMdbI7RpuO0b6EtLje7xHY
         ve9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tvXl0W+WJwpnbxy3THEOQYack8Z4j8OQae2L4gnwAYw=;
        b=UiVsp81JtN+pRt5Edc5s5ledNll6QJSM9ZzrKvQxnlmpcbUE2lue8GJB+W7rppbZrb
         nBUSjr0Fbf8iPeMPq/bQ7YIR+EhCfxrSX+xWND84EL4fQ4SHvWZaDwrIuyeRkaSYHJx+
         2KxyTBapEXGrPBL76QsyTXUguWiP4iKaQRnbYRSGk1++CmlV8dVvTjpMzStGe8wELL4/
         8cRdLtl8xwxFsaWBdPrRzhGS4P6Rblf87ar5Ptak0YZiTi6cA6SxdnSdrblR1pdtK+/J
         ACE08MZGgqifkcGtvwxGrXNIT903yKobRrI0X+NO1c7U0CwDRUloABskptPmH8WjQUyU
         0GjA==
X-Gm-Message-State: AOAM53271rXYTzRyTujmkmDzKlBhPbmadA/OGo4Ei1oQbi0rpdyJPGfl
        H2RWbXsPr1JWwTMees0fvgQ=
X-Google-Smtp-Source: ABdhPJzZP4Av12s27l37IvWOJLfwhQy/pjMU1yhNooTJw0Ezq0+QCo+MtUQwxvHm17IA01AeQXd1yA==
X-Received: by 2002:adf:dd90:: with SMTP id x16mr6766025wrl.85.1608335876277;
        Fri, 18 Dec 2020 15:57:56 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id h15sm15020751wru.4.2020.12.18.15.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 15:57:55 -0800 (PST)
Subject: Re: [PATCH v2 12/12] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-13-djrscally@gmail.com>
 <X9zehD1xtQP/bxXu@pendragon.ideasonboard.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <5c0ae9f8-ba58-a26c-400b-7d85d01087a3@gmail.com>
Date:   Fri, 18 Dec 2020 23:57:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X9zehD1xtQP/bxXu@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Laurent - thanks for the comments

On 18/12/2020 16:53, Laurent Pinchart wrote:
>> +static void cio2_bridge_init_property_names(struct cio2_sensor *sensor)
>> +{
>> +	strscpy(sensor->prop_names.clock_frequency, "clock-frequency",
>> +		sizeof(sensor->prop_names.clock_frequency));
>> +	strscpy(sensor->prop_names.rotation, "rotation",
>> +		sizeof(sensor->prop_names.rotation));
>> +	strscpy(sensor->prop_names.bus_type, "bus-type",
>> +		sizeof(sensor->prop_names.bus_type));
>> +	strscpy(sensor->prop_names.data_lanes, "data-lanes",
>> +		sizeof(sensor->prop_names.data_lanes));
>> +	strscpy(sensor->prop_names.remote_endpoint, "remote-endpoint",
>> +		sizeof(sensor->prop_names.remote_endpoint));
>> +	strscpy(sensor->prop_names.link_frequencies, "link-frequencies",
>> +		sizeof(sensor->prop_names.link_frequencies));
> 
> Just curious, was there anything not working correctly with the proposal
> I made ?
> 
> static const struct cio2_property_names prop_names = {
> 	.clock_frequency = "clock-frequency",
> 	.rotation = "rotation",
> 	.bus_type = "bus-type",
> 	.data_lanes = "data-lanes",
> 	.remote_endpoint = "remote-endpoint",
> };
> 
> static void cio2_bridge_init_property_names(struct cio2_sensor *sensor)
> {
> 	sensor->prop_names = prop_names;
> }
> 
> It generates a warning when the string is too long for the field size,
> which should help catching issues at compilation time.

Yes, though I don't know how much of a real-world problem it would have
been - if you recall we have the issue that the device grabs a reference
to the software_nodes (after we stopped delaying until after the
i2c_client is available), which means we can't safely free the
cio2_bridge struct on module unload. That also means we can't rely on
those pointers to string literals existing, because if the ipu3-cio2
module gets unloaded they'll be gone.

Shame, as it's way neater.

>> +static void cio2_bridge_init_swnode_names(struct cio2_sensor *sensor)
>> +{
>> +	snprintf(sensor->node_names.remote_port, 7, "port@%u", sensor->ssdb.link);
>> +	strscpy(sensor->node_names.port, "port@0", sizeof(sensor->node_names.port));
>> +	strscpy(sensor->node_names.endpoint, "endpoint@0", sizeof(sensor->node_names.endpoint));
> 
> I'd wrap lines, but maybe that's because I'm an old-school, 80-columns
> programmer :-)

Heh sure, I'll wrap them.

>> +static int cio2_bridge_connect_sensors(struct cio2_bridge *bridge,
>> +				       struct pci_dev *cio2)
>> +{
>> +	struct fwnode_handle *fwnode;
>> +	struct cio2_sensor *sensor;
>> +	struct acpi_device *adev;
>> +	unsigned int i;
>> +	int ret = 0;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(cio2_supported_sensors); i++) {
>> +		const struct cio2_sensor_config *cfg = &cio2_supported_sensors[i];
>> +
>> +		for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
>> +			if (bridge->n_sensors >= CIO2_NUM_PORTS) {
>> +				dev_warn(&cio2->dev, "Exceeded available CIO2 ports\n");
>> +				/* overflow i so outer loop ceases */
>> +				i = ARRAY_SIZE(cio2_supported_sensors);
>> +				break;
> 
> Or just
> 
> 				return 0;
> 
> ?

Derp, yes of course.


>> +/* Data representation as it is in ACPI SSDB buffer */
>> +struct cio2_sensor_ssdb {
>> +	u8 version;				/* 0000 */
>> +	u8 sku;					/* 0001 */
>> +	u8 guid_csi2[16];			/* 0002 */
>> +	u8 devfunction;				/* 0003 */
>> +	u8 bus;					/* 0004 */
>> +	u32 dphylinkenfuses;			/* 0005 */
>> +	u32 clockdiv;				/* 0009 */
>> +	u8 link;				/* 0013 */
>> +	u8 lanes;				/* 0014 */
>> +	u32 csiparams[10];			/* 0015 */
>> +	u32 maxlanespeed;			/* 0019 */
>> +	u8 sensorcalibfileidx;			/* 0023 */
>> +	u8 sensorcalibfileidxInMBZ[3];		/* 0024 */
>> +	u8 romtype;				/* 0025 */
>> +	u8 vcmtype;				/* 0026 */
>> +	u8 platforminfo;			/* 0027 */
> 
> Why stop at 27 ? :-) I'd either go all the way, or not at all. It's also
> quite customary to represent offset as hex values, as that's what most
> hex editors / viewers will show.

Oops - that was actually just me debugging...I guess I might actually
finish it, converted to hex. It came in useful reading the DSDT to have
that somewhere easy to refer to.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Nice - thank you!
