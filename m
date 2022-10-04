Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B00E5F485E
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Oct 2022 19:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJDR1S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Oct 2022 13:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJDR1N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Oct 2022 13:27:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BD75F102
        for <linux-acpi@vger.kernel.org>; Tue,  4 Oct 2022 10:27:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j7so17021318wrr.3
        for <linux-acpi@vger.kernel.org>; Tue, 04 Oct 2022 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/YyTjuq72jPuEDAkHmrIcGfQEw89UamE4234MBXV7M=;
        b=uMNscTXfVp1XcvvH3eELBtEjbKgaXl4c6QBHfJoOtBNGqoIT74k6Z+iv7KETLsf/+z
         /eZxN1xc4aU+VLXZt8wrd0EPElxdHLvBPS7pbMgOz8sfXGFKaJP226csW7xKnNFx5/ky
         jPNpNdkvnaNtJGAOQr5Mppd7vhvpMmRL5qil2FcFdnGYJU8zWjq+WKGF+kkJhps1wxyg
         jSKMlAAX4xteHY09iSnwCGY1+GoxMz4g8ShNwXiV0H4nbYSLGkMyF5zel8RIqPx8SWMw
         3O+nv907n1rElz7mH2w29j9bCRrOT7e3zhzKVDcqbUsBfBiNFZzXjVz+Ge4dVceY5wSG
         8PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/YyTjuq72jPuEDAkHmrIcGfQEw89UamE4234MBXV7M=;
        b=XqMjaHJSJi+1DcbPxAvYZz4mUVxR9GG5dlWl64zLrNoS79mmbhWGpnW65xpXi6I/VX
         nmJ4Sbix5bQ8jSlqXTKL378/VDGZJ6sQR5RYvy/pgTsY5/P0ERS4cC/FmQ3wTxfnBD0W
         8fHvr3a+LBLq8YMxaeUhjfuU2JQDhZCT43u4ws4cVgU1xFGf8h2fwWJHC+zDlPhaOXhN
         JFHI0c+AuRlNWbyAMWfAw3fZXAEqa023tcMOnfdJliAsOpGuBG15UjFYTIUXKzSuxjJ7
         oSPZeWg6ykQbDKxUHJJWzf9i4ELbW4dCoXk0JnWE4adaLchxhEytteQb4STp7PGSWPGc
         Hosg==
X-Gm-Message-State: ACrzQf2awovMEbKkf27mR+GYrFfqso1SE5J8BZOtUPIDoEjlsNTO5lZ3
        2IkWqmcj3YRh4MFDzBVBE7yIfw==
X-Google-Smtp-Source: AMsMyM7eM2MqbsI26hUF8cdejktV0Fb2N4hpKCRdY1miuh+p/YeKBiq26ZYFa9sRudB/orQu/ipWZg==
X-Received: by 2002:adf:f911:0:b0:21e:c0f6:fd26 with SMTP id b17-20020adff911000000b0021ec0f6fd26mr16849049wrr.361.1664904426795;
        Tue, 04 Oct 2022 10:27:06 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm13060941wrc.62.2022.10.04.10.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:27:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/9] ACPI thermal cleanups
Date:   Tue,  4 Oct 2022 19:26:49 +0200
Message-Id: <20221004172658.2302511-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <12068304.O9o76ZdvQC@kreacher>
References: <12068304.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The thermal framework is being cleanup by changing how the thermal trips are
managed. In this process, the ACPI thermal drivers deserves a big cleanup in
order to use the generic trip points.

This series, which is still work in progress, has been tested on an ACPI based
platform.

Daniel Lezcano (9):
  thermal/acpi: Remove the intermediate acpi_thermal_trip structure
  thermal/acpi: Change to a common acpi_thermal_trip structure
  thermal/acpi: Convert the acpi thermal trips to an array
  thermal/acpi: Move the active trip points to the same array
  thermal/acpi: Optimize get_trip_points()
  thermal/acpi: Encapsualte in functions the trip initialization
  thermal/acpi: Simplifify the condition check
  thermal/acpi: Remove active and enabled flags
  thermal/acpi: Rewrite the trip point intialization to use the generic
    thermal trip

 drivers/acpi/thermal.c | 670 ++++++++++++++++++++++++++---------------
 1 file changed, 433 insertions(+), 237 deletions(-)

-- 
2.34.1

