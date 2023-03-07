Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15F66AE60F
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Mar 2023 17:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCGQN4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Mar 2023 11:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCGQNy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2023 11:13:54 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139064D28D;
        Tue,  7 Mar 2023 08:13:49 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id s1so12772590vsk.5;
        Tue, 07 Mar 2023 08:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678205628;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iFMVUX6mWLWLaXQmuw9bgeq2RNNlCPcRlcQ7VbAfcZE=;
        b=InfpYRTvh0lDWZ0IlIuWLMqMXOugoFq+bUqccxqGq1c6XPSsqbfUkRfX5HdBBkNnWU
         N0+eSv+7ggCbAqsOi11uDBMmPJe92+HJ7+fceUYhMUjbnrzvEWWK2pg5UdX2vHOgShY3
         Io726VtSdxD7LoroqbDxec+yxfP1BF3pllAd1kulAXj/zoDU3FiofgaqH0xiLhCd6zgi
         8tMbWMf6B4pkm167ElxaS92EfmrPKIdvDfCMj9I92co6g1H4evXE+0KOaGgu7/NnOMxe
         jcoZZ7zWyLKRkVMYka2DkiD26qKtilIhlwoocfeY8BDvyQRj7XpmXKzg3D//HaRAv4iw
         ijsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678205628;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFMVUX6mWLWLaXQmuw9bgeq2RNNlCPcRlcQ7VbAfcZE=;
        b=v2q5yvMjPEo4d/ZAqnMPIyq+Fr9+OaKQGByM8uD4AZbompkwtSyx65+NFTBljgrRzr
         SRzGbrz4drbJTXInS5OfJhTrnoJmmm9EzG/VtKJbekwFOmyX/A2gxsHeCo9L0/nGt02y
         zf+6B7XePOfl3rjQz2wcvoCdh+Vcrzujizg4v/R6qwu+PhVUGK8+RYQQEgHvPWIbJ5C0
         FwTuNkU+5QInIi/KorSuQAu3t2jRcTDUBs0QKI/CtpxyktAc2FDBXtd64/qY6zUkpJCU
         5fFG+NV4CxVMkL2buTH6C+ILmG1a0KxrKCo92Av571F1KnN9lPMubghsiBPrlFA81PMk
         x+RA==
X-Gm-Message-State: AO0yUKX6uofIQbKxOTwY+GOTMIM0+jJRsCkFAnN/R4QVTqfhj39v3TSv
        HLZ+8s3hZV2kTNgLZtPEJJ0hXjKd5AZ0oSWRzym1Udq9dwA=
X-Google-Smtp-Source: AK7set+er6xpEYdkcTh4MHAzyCjoIjtPX8YStIUfm3aN+XN81pa+UCG2Jn1/mGhxMOw4JCNRuj9togXVrz+Aie0cEpg=
X-Received: by 2002:a67:b142:0:b0:41b:dc0c:a668 with SMTP id
 z2-20020a67b142000000b0041bdc0ca668mr10131559vsl.7.1678205628447; Tue, 07 Mar
 2023 08:13:48 -0800 (PST)
MIME-Version: 1.0
From:   Daniel Kaehn <kaehndan@gmail.com>
Date:   Tue, 7 Mar 2023 10:13:38 -0600
Message-ID: <CAP+ZCCd0cD+q7=ngyEzScAte2VT9R00mqCQxB3K2TMbeg8UAfA@mail.gmail.com>
Subject: ACPI vs. DT - Casing and Other Differences with Named Child Nodes
To:     devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        ethan.twardy@plexus.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello All,

Recently, an interesting ACPI vs. DT case arose with a patchset adding DT
bindings and fwnode support (using the firmware-independent device_* api)
for the CP2112, a USB-HID device which provides a GPIO chip and an I2C
controller [1].

The DT binding and driver use the named child nodes - "i2c" and "gpio" -
to be assigned to the child I2C controller and GPIO chip, respectively.
This seems to be a common practice in DT (children named "mdio",
"connector", or "ports", for example), and an ACPIimplementation of the
`get_named_child_node` fwnode operation _does_ exist
(acpi_fwnode_get_named_child_node). However, ACPI node names are always
uppercase, and it seems that these names tend not to carry meaning, and
potentially shouldn't be used to identify a node in a driver. DeviceTree,
in contrast, does allow for uppercase or lowercase node names (if I'm
reading the specification correctly), but
1) It seems that node names are lowercase by convention, from the current
bindings, and
2) node names appear to be technically case-sensitive, per the spec and
[2]

In other words, the patchset in [1] inherently won't work for ACPI in the
current state, since it accesses children by lowercase names, a.e.
`device_get_named_child_node(&hdev->dev,"i2c")`

How can the identification of child nodes within a driver/device be
unified in both languages? Is this a problem that has already been solved?

Some suggestions thus far:

- In the (any) driver, first try to access nodes by name per the DT binding,
then fall-back to accessing nodes by index (a.e. "i2c" is child Zero,
"gpio" is child One). Alternatively, instead of first trying named access,
determine the type of access based on if the passed fw_node is
DT or ACPI (or other). Ideally, this would take the form of a / some new
fwnode/device API functions, so that device drivers wouldn't have to code
for the nuances of each different firmware description language.

- Since ACPI node names are technically "case insensitive" (a.e. iasl
translates them to uppercase if the are specified as lowercase), would it
be valid to do a case insensitive compare in
`acpi_fwnode_get_named_child_node`? Of course, this doesn't address the
issue that ACPI node names shouldn't necessarily be used as identifiers, but
it seems there is _some_ precedence of using named child nodes for ACPI
in mainline kernel code (a.e. drivers/platform/x86/intel accesses the
(uppercase) named child "DD04").


Any additional discussion or suggestions are most welcome!

Thanks,

Danny Kaehn

[1]
https://patchwork.kernel.org/project/linux-input/patch/20230227140758.1575-4-kaehndan@gmail.com/
[2] https://www.spinics.net/lists/devicetree-spec/msg00328.html
