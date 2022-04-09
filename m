Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD314FA594
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Apr 2022 09:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiDIHYp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Apr 2022 03:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiDIHYo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Apr 2022 03:24:44 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB8E140FA;
        Sat,  9 Apr 2022 00:22:37 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae90c.dynamic.kabel-deutschland.de [95.90.233.12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 991DD61E6478B;
        Sat,  9 Apr 2022 09:22:35 +0200 (CEST)
Message-ID: <e28cec02-f91b-0087-6162-03b77581c731@molgen.mpg.de>
Date:   Sat, 9 Apr 2022 09:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support to configure TX power
Content-Language: en-US
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com,
        Seema S <seema.sreemantha@intel.com>,
        linux-acpi@vger.kernel.org
References: <20220408080633.20463-1-kiran.k@intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220408080633.20463-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Cc: +linux-acpi to check for best practices in ACPI table handling]


Dear Kiran,


Am 08.04.22 um 10:06 schrieb Kiran K:

Thank you for the patch. Maybe as commit message summary:

Support to configure TX power using BRDS ACPI table

> BRDS - Bluetooth Regulatory Domain Specific absorption rate
> -----------------------------------------------------------

Why this header? Integrate the long table name into the message below.

> 
> Bluetooth has regulatory limitations which prohibit or allow usage
> of certain bands or channels as well as limiting Tx power. The Tx power
> values can be configured in ACPI table. This patch reads ACPI entry of
> Bluetooth SAR and configures the controller accordingly.

It’d be great if you elaborated a little on the implementation? For 
example, what is the legacy SAR needed for?

How did you test this? What device and firmware providing the BRDS 
table? Maybe even paste the ASL table here as an example.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Seema S <seema.sreemantha@intel.com>
> ---
>   drivers/bluetooth/btintel.c | 229 ++++++++++++++++++++++++++++++++++++
>   drivers/bluetooth/btintel.h |  18 +++
>   2 files changed, 247 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 818681c89db8..d3dc703eba78 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -9,6 +9,7 @@
>   #include <linux/module.h>
>   #include <linux/firmware.h>
>   #include <linux/regmap.h>
> +#include <linux/acpi.h>
>   #include <asm/unaligned.h>
>   
>   #include <net/bluetooth/bluetooth.h>
> @@ -32,6 +33,9 @@ struct cmd_write_boot_params {
>   	u8  fw_build_yy;
>   } __packed;
>   
> +#define BTINTEL_SAR_NAME	"BRDS"
> +#define BTINTEL_SAR_PREFIX	"\\_SB_.PC00.XHCI.RHUB"
> +
>   int btintel_check_bdaddr(struct hci_dev *hdev)
>   {
>   	struct hci_rp_read_bd_addr *bda;
> @@ -2250,6 +2254,228 @@ static int btintel_configure_offload(struct hci_dev *hdev)
>   	return err;
>   }
>   
> +static acpi_status btintel_sar_callback(acpi_handle handle, u32 lvl, void *data,
> +					void **ret)
> +{
> +	acpi_status status;
> +	int len;

size_t

> +	struct btintel_sar *sar;
> +	union acpi_object *p, *elements;
> +	struct acpi_buffer string = {ACPI_ALLOCATE_BUFFER, NULL};
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +
> +	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
> +	if (ACPI_FAILURE(status)) {
> +		BT_DBG("ACPI Failure: %s", acpi_format_exception(status));
> +		return status;
> +	}
> +
> +	if (strncmp(BTINTEL_SAR_PREFIX, string.pointer,
> +		    strlen(BTINTEL_SAR_PREFIX))) {
> +		kfree(string.pointer);
> +		return AE_OK;
> +	}
> +
> +	len = strlen(string.pointer);
> +	if (strncmp((char *)string.pointer + len - 4, BTINTEL_SAR_NAME, 4)) {
> +		kfree(string.pointer);
> +		return AE_OK;
> +	}
> +	kfree(string.pointer);
> +
> +	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		BT_DBG("ACPI Failure: %s", acpi_format_exception(status));
> +		return status;
> +	}
> +
> +	p = buffer.pointer;
> +	sar = data;
> +
> +	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 2) {
> +		kfree(buffer.pointer);
> +		BT_DBG("Invalid object type or package count");

Please add the variable values to the debug line.

> +		return AE_ERROR;
> +	}
> +
> +	elements = p->package.elements;
> +
> +	/* SAR table is located at element[1] */
> +	p = &elements[1];
> +
> +	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 8) {
> +		kfree(buffer.pointer);
> +		return AE_ERROR;
> +	}
> +
> +	sar->domain = (u8)p->package.elements[0].integer.value;
> +	sar->type = (u8)p->package.elements[1].integer.value;
> +	sar->br = (u32)p->package.elements[2].integer.value;
> +	sar->edr2 = (u32)p->package.elements[3].integer.value;
> +	sar->edr3 = (u32)p->package.elements[4].integer.value;
> +	sar->le = (u32)p->package.elements[5].integer.value;
> +	sar->le_2mhz = (u32)p->package.elements[6].integer.value;
> +	sar->le_lr  = (u32)p->package.elements[7].integer.value;
> +	kfree(buffer.pointer);
> +	return AE_CTRL_TERMINATE;
> +}
> +
> +static void btintel_send_sar_ddc(struct hci_dev *hdev, void *data, u8 len)

Use native type for `len`? `unsigned int`?

> +{
> +	struct sk_buff *skb;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc8b, len, data, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_warn(hdev, "Failed to send Intel Write SAR DDC (%ld)", PTR_ERR(skb));
> +		return;
> +	}
> +	kfree_skb(skb);
> +}
> +
> +static int btintel_set_legacy_sar(struct hci_dev *hdev, struct btintel_sar *sar)
> +{
> +	struct btintel_cp_ddc_write	*cmd;
> +	u8	buffer[64];

Don’t try to align with tabs?

> +
> +	if (!sar)
> +		return -EINVAL;
> +
> +	cmd = (void *)buffer;
> +
> +	cmd->len = 3;
> +	cmd->id = cpu_to_le16(0x0131);

Add names for the command id’s?

> +	cmd->data[0] = sar->br >> 3;
> +	btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +	cmd->len = 3;
> +	cmd->id = cpu_to_le16(0x0132);
> +	cmd->data[0] = sar->br >> 3;
> +	btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +	cmd->len = 5;
> +	cmd->id = cpu_to_le16(0x0137);
> +	cmd->data[0] = sar->br >> 3;
> +	cmd->data[1] = sar->edr2 >> 3;
> +	cmd->data[2] = sar->edr3 >> 3;
> +	btintel_send_sar_ddc(hdev, cmd, 6);
> +
> +	cmd->len = 5;
> +	cmd->id = cpu_to_le16(0x0138);
> +	cmd->data[0] = sar->br >> 3;
> +	cmd->data[1] = sar->edr2 >> 3;
> +	cmd->data[2] = sar->edr3 >> 3;
> +	btintel_send_sar_ddc(hdev, cmd, 6);
> +
> +	cmd->len = 5;
> +	cmd->id = cpu_to_le16(0x013b);
> +	cmd->data[0] = sar->br >> 3;
> +	cmd->data[1] = sar->edr2 >> 3;
> +	cmd->data[2] = sar->edr3 >> 3;
> +	btintel_send_sar_ddc(hdev, cmd, 6);
> +
> +	cmd->len = 5;
> +	cmd->id = cpu_to_le16(0x013c);
> +	cmd->data[0] = sar->br >> 3;
> +	cmd->data[1] = sar->edr2 >> 3;
> +	cmd->data[2] = sar->edr3 >> 3;
> +	btintel_send_sar_ddc(hdev, cmd, 6);
> +
> +	return 0;
> +}
> +
> +static int btintel_set_mutual_sar(struct hci_dev *hdev, struct btintel_sar *sar)
> +{
> +	u8 buffer[64];
> +	struct btintel_cp_ddc_write *cmd;
> +	u8 enable[1] = {1};
> +	struct sk_buff *skb;
> +
> +	if (!sar)
> +		return -EINVAL;
> +
> +	cmd = (void *)buffer;
> +
> +	cmd->len = 3;
> +	cmd->id = cpu_to_le16(0x019e);
> +	if (!(sar->le_2mhz & BIT(7)))
> +		cmd->data[0] = 0x01;
> +	else
> +		cmd->data[0] = 0x00;

Use ternary operator?

> +	btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +	cmd->len = 3;
> +	cmd->id = cpu_to_le16(0x019f);
> +	cmd->data[0] = sar->le_lr;
> +	btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +	cmd->len = 3;
> +	cmd->id = cpu_to_le16(0x01a0);
> +	cmd->data[0] = sar->br;
> +	btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +	cmd->len = 3;
> +	cmd->id = cpu_to_le16(0x01a1);
> +	cmd->data[0] = sar->edr2;
> +	btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +	cmd->len = 3;
> +	cmd->id = cpu_to_le16(0x01a2);
> +	cmd->data[0] = sar->edr3;
> +	btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +	cmd->len = 3;
> +	cmd->id = cpu_to_le16(0x01a3);
> +	cmd->data[0] = sar->le;
> +	btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +	skb = __hci_cmd_sync(hdev, 0xfe25, 1, enable, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_warn(hdev, "Failed to send Intel SAR Enable (%ld)", PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
> +static int btintel_set_specific_absorption_rate(struct hci_dev *hdev,
> +						struct intel_version_tlv *ver)
> +{
> +	acpi_status status;
> +	struct btintel_sar sar;
> +
> +	switch (ver->cnvr_top & 0xfff) {
> +	case 0x810: /* MsP */
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	memset(&sar, 0, sizeof(sar));
> +
> +	status = acpi_walk_namespace(ACPI_TYPE_METHOD, ACPI_ROOT_OBJECT,
> +				     ACPI_UINT32_MAX, NULL,
> +				     btintel_sar_callback, &sar, NULL);
> +
> +	if (ACPI_FAILURE(status))
> +		return -1;
> +
> +	if (sar.domain != 0x12)
> +		return -1;
> +
> +	/* No need to configure controller if Bluetooth SAR is disabled in BIOS
> +	 */

Put it on the line above?

> +	if (!sar.type)
> +		return 0;
> +
> +	if (sar.type == 1) {
> +		bt_dev_info(hdev, "Applying both legacy and mutual Bluetooth SAR");
> +		btintel_set_legacy_sar(hdev, &sar);
> +		btintel_set_mutual_sar(hdev, &sar);
> +	}
> +	return 0;
> +}
> +
>   static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>   					struct intel_version_tlv *ver)
>   {
> @@ -2294,6 +2520,9 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>   	/* Read supported use cases and set callbacks to fetch datapath id */
>   	btintel_configure_offload(hdev);
>   
> +	/* Set Specific Absorption Rate */
> +	btintel_set_specific_absorption_rate(hdev, ver);
> +
>   	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
>   
>   	/* Read the Intel version information after loading the FW  */
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index e0060e58573c..7aa58fb7b02a 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -137,6 +137,24 @@ struct intel_offload_use_cases {
>   	__u8	preset[8];
>   } __packed;
>   
> +/* structure to store the data read from ACPI table */
> +struct btintel_sar {
> +	u8	domain;
> +	u8	type;
> +	u32	br;
> +	u32	edr2;
> +	u32	edr3;
> +	u32	le;
> +	u32	le_2mhz;
> +	u32	le_lr;

Can’t native types be used?

> +};
> +
> +struct btintel_cp_ddc_write {
> +	u8	len;
> +	__le16	id;
> +	u8	data[0];
> +} __packed;
> +
>   #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
>   #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
>   #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
