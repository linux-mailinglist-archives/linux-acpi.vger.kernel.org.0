Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286AF4C2CC3
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Feb 2022 14:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiBXNJy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Feb 2022 08:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiBXNJq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Feb 2022 08:09:46 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427D664BE7;
        Thu, 24 Feb 2022 05:09:14 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j17so3017815wrc.0;
        Thu, 24 Feb 2022 05:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0AbxvT+UyjtLUUrp5lGkKPXG8e9imCtSOESDE/pQxuM=;
        b=lIXgRwvFNHNnJeIBba6FtLtsdPzBhww7T0PlUQ3GNveupxGShGNu4bQYdbykvAYv2q
         2YVoIgYrVtcJ5rQaeCSYBjUZKezKLe3bK5M4aWNCbJw1JRS5X9hw3LxURmgBGcHbyBp8
         sKMKIG8oeSSFjwidD6Dusjo3iLkHGDYaomSD1DCDsEoLrBpBIiCwp3ljttbfr6rn6sBM
         fMQgrDy9sMbojMM+ryTteps7Q0CDoN7TYgoUxXZFhPOresET8LsPwlC3y8cfMHs2d7KS
         aAZYBLcoI4WKqvg93LkTTG+cu3BC6SZs18Re4IvnnGBrMvo+qiIcun9FwtvJgTemibsb
         kz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0AbxvT+UyjtLUUrp5lGkKPXG8e9imCtSOESDE/pQxuM=;
        b=Z+HsLyjlCbpZD60AJrUmtZmgjeVu5NZy4AYvbHH6cDrmcXUnSLovKVaTAOwLNbhLU+
         VVMF2sGTi1knUVyTr0B02Db265h1DXYrbwESKwqQggYwiJ1wsaxTEI9dm0ckknz9edt9
         SwOzURFwjA2f95sX5EkhWxvyuxvbXJZX2dfaydbE3C+4u4Vhe2NPvNTFFMwukLFWAhcN
         pUcWfGuvbFamavlSWjm4AMgeOPW/Ta4ypFh3SkVXEa87J5xZRDojEXapeLL0q87ypcKa
         i/ax67gw8lR84ED1H8JRtNPTA7dV1Bk6jyrxyN8u445yT1zKP/a/o87FWa09MDWNi7GU
         KhgQ==
X-Gm-Message-State: AOAM532r5S56LmCMVUEu2fhJ+nTEOW+nW4uEZbVmqDn1vNtzyJ20Yc5Q
        5YQfvG7CwlQX83wmzRuf5gFRZzqt9kwVZA==
X-Google-Smtp-Source: ABdhPJwrwJOBEQIN411koZhXcJQVzbWRCkdHf4VrhmdhbK0fuboz36Lw/UjrsU4p4SXyL2FVBU46Qg==
X-Received: by 2002:a5d:628d:0:b0:1ed:f981:ccc with SMTP id k13-20020a5d628d000000b001edf9810cccmr1520491wru.616.1645708152879;
        Thu, 24 Feb 2022 05:09:12 -0800 (PST)
Received: from [10.16.0.7] ([194.126.177.11])
        by smtp.gmail.com with ESMTPSA id r2-20020a05600c35c200b00352cdcdd7b2sm12326027wmq.0.2022.02.24.05.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 05:09:12 -0800 (PST)
Message-ID: <fc05d480-49f4-bb6f-3f21-531085ec226f@gmail.com>
Date:   Thu, 24 Feb 2022 14:09:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] platform/surface: Remove Surface 3 Button driver
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220224110241.9613-1-hdegoede@redhat.com>
 <20220224110241.9613-3-hdegoede@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220224110241.9613-3-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2/24/22 12:02, Hans de Goede wrote:
> The Surface 3 buttons are now handled by the generic soc_button_array
> driver. As part of adding support to soc_button_array the ACPI code
> now instantiates a platform_device rather then an i2c_client so there
> no longer is an i2c_client for this driver to bind to.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com
