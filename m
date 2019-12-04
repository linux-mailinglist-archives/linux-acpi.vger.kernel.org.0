Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D83112767
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2019 10:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfLDJav (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Dec 2019 04:30:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34887 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfLDJav (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2019 04:30:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id k196so6262437oib.2;
        Wed, 04 Dec 2019 01:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1wPeZTIIlORKYQ9nx5sgoocKreccnt1+PctvRn+gAs=;
        b=IQ3AcVhchDiToYN47aGhxryY/UAFpAH3ezNQD8bq2wyV+n6ExpLng+oFnoHqpJ02VN
         nccLK/6OQOacGRUG88nINy7JcJjNfhEfcXcUgewULLj7xy766+Ihoux9R6QHR8863ME7
         Y8tq5XZwAFWaNPJUBp7mfNpQ3fY/jNrJQ77HhxQ4J7uH/gPgKz54m1ic62plnfBQO0cH
         FvcX2oBrawjebFomkGAbI7POkocgyYexfNBawo9QrU/CfrXvvVLHz5x6ZXhWHDPpqXCs
         QR1NM6RECuywvuB+9Ags2EzfxmzQxHvdTZNyXlIbuK0T7lS7z/0ZuzJR8UFacUzC9fqB
         2WLQ==
X-Gm-Message-State: APjAAAWgBpwJYEgH+zRHx+0Mz6KOTa/eoNMrWmol1QnV1v3rouzl/nra
        Yp7f9DPMsSnOeNCzxmd5gI2PCwIkvHNNc2ALI1g=
X-Google-Smtp-Source: APXvYqyQMn8qVMa567Fw+mI3uTll7XsYkshjDqKOsIaPbmemQmsvdLF6N7w9dcijkjUCyPeQrgpfXoPatwTSd0TTLUw=
X-Received: by 2002:aca:4f48:: with SMTP id d69mr1808201oib.103.1575451849488;
 Wed, 04 Dec 2019 01:30:49 -0800 (PST)
MIME-Version: 1.0
References: <201912040922.hUcG8uqP%lkp@intel.com>
In-Reply-To: <201912040922.hUcG8uqP%lkp@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Dec 2019 10:30:37 +0100
Message-ID: <CAJZ5v0hO7TUado+foOX7QN7nGKKk5Ha7JV8QBYLk3594ky5kMg@mail.gmail.com>
Subject: Re: [pm:bleeding-edge 6/7] drivers/base/test/property-entry-test.c:454:1:
 warning: the frame size of 2960 bytes is larger than 2048 bytes
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kbuild-all@lists.01.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 4, 2019 at 2:07 AM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   88a29de6adffb9d4d1ac7f1b1d996c616ebda145
> commit: 80e0582b1ab83ed08dedaad5a0cdb28457ccba4f [6/7] software node: add basic tests for property entries
> config: arm64-randconfig-a001-20191203 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 80e0582b1ab83ed08dedaad5a0cdb28457ccba4f
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=arm64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    drivers/base/test/property-entry-test.c: In function 'pe_test_reference':
> >> drivers/base/test/property-entry-test.c:454:1: warning: the frame size of 2960 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>     }
>     ^
>    drivers/base/test/property-entry-test.c: In function 'pe_test_uint_arrays':
>    drivers/base/test/property-entry-test.c:214:1: warning: the frame size of 4288 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>     }
>     ^
>    drivers/base/test/property-entry-test.c: In function 'pe_test_uints':
>    drivers/base/test/property-entry-test.c:99:1: warning: the frame size of 2736 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>     }
>     ^

Dmitry, any comments on this?

Perhaps I should drop the tests patch until this is resolved or clarified?

> vim +454 drivers/base/test/property-entry-test.c
>
>    360
>    361  /* Handling of reference properties */
>    362  static void pe_test_reference(struct kunit *test)
>    363  {
>    364          const struct software_node nodes[] = {
>    365                  { .name = "1", },
>    366                  { .name = "2", },
>    367          };
>    368
>    369          const struct software_node_ref_args refs[] = {
>    370                  {
>    371                          .node = &nodes[0],
>    372                          .nargs = 0,
>    373                  },
>    374                  {
>    375                          .node = &nodes[1],
>    376                          .nargs = 2,
>    377                          .args = { 3, 4 },
>    378                  },
>    379          };
>    380
>    381          const struct property_entry entries[] = {
>    382                  PROPERTY_ENTRY_REF("ref-1", &nodes[0]),
>    383                  PROPERTY_ENTRY_REF("ref-2", &nodes[1], 1, 2),
>    384                  PROPERTY_ENTRY_REF_ARRAY("ref-3", refs),
>    385                  { }
>    386          };
>    387
>    388          struct fwnode_handle *node;
>    389          struct fwnode_reference_args ref;
>    390          int error;
>    391
>    392          error = software_node_register_nodes(nodes);
>    393          KUNIT_ASSERT_EQ(test, error, 0);
>    394
>    395          node = fwnode_create_software_node(entries, NULL);
>    396          KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
>    397
>    398          error = fwnode_property_get_reference_args(node, "ref-1", NULL,
>    399                                                     0, 0, &ref);
>    400          KUNIT_ASSERT_EQ(test, error, 0);
>    401          KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[0]);
>    402          KUNIT_EXPECT_EQ(test, ref.nargs, 0U);
>    403
>    404          /* wrong index */
>    405          error = fwnode_property_get_reference_args(node, "ref-1", NULL,
>    406                                                     0, 1, &ref);
>    407          KUNIT_EXPECT_NE(test, error, 0);
>    408
>    409          error = fwnode_property_get_reference_args(node, "ref-2", NULL,
>    410                                                     1, 0, &ref);
>    411          KUNIT_ASSERT_EQ(test, error, 0);
>    412          KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[1]);
>    413          KUNIT_EXPECT_EQ(test, ref.nargs, 1U);
>    414          KUNIT_EXPECT_EQ(test, ref.args[0], 1LLU);
>    415
>    416          /* asking for more args, padded with zero data */
>    417          error = fwnode_property_get_reference_args(node, "ref-2", NULL,
>    418                                                     3, 0, &ref);
>    419          KUNIT_ASSERT_EQ(test, error, 0);
>    420          KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[1]);
>    421          KUNIT_EXPECT_EQ(test, ref.nargs, 3U);
>    422          KUNIT_EXPECT_EQ(test, ref.args[0], 1LLU);
>    423          KUNIT_EXPECT_EQ(test, ref.args[1], 2LLU);
>    424          KUNIT_EXPECT_EQ(test, ref.args[2], 0LLU);
>    425
>    426          /* wrong index */
>    427          error = fwnode_property_get_reference_args(node, "ref-2", NULL,
>    428                                                     2, 1, &ref);
>    429          KUNIT_EXPECT_NE(test, error, 0);
>    430
>    431          /* array of references */
>    432          error = fwnode_property_get_reference_args(node, "ref-3", NULL,
>    433                                                     0, 0, &ref);
>    434          KUNIT_ASSERT_EQ(test, error, 0);
>    435          KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[0]);
>    436          KUNIT_EXPECT_EQ(test, ref.nargs, 0U);
>    437
>    438          /* second reference in the array */
>    439          error = fwnode_property_get_reference_args(node, "ref-3", NULL,
>    440                                                     2, 1, &ref);
>    441          KUNIT_ASSERT_EQ(test, error, 0);
>    442          KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[1]);
>    443          KUNIT_EXPECT_EQ(test, ref.nargs, 2U);
>    444          KUNIT_EXPECT_EQ(test, ref.args[0], 3LLU);
>    445          KUNIT_EXPECT_EQ(test, ref.args[1], 4LLU);
>    446
>    447          /* wrong index */
>    448          error = fwnode_property_get_reference_args(node, "ref-1", NULL,
>    449                                                     0, 2, &ref);
>    450          KUNIT_EXPECT_NE(test, error, 0);
>    451
>    452          fwnode_remove_software_node(node);
>    453          software_node_unregister_nodes(nodes);
>  > 454  }
>    455
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
