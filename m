Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02B541F4DB
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Oct 2021 20:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355745AbhJAST2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Oct 2021 14:19:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60786 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355734AbhJAST1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2021 14:19:27 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 95830a2db29d0bf3; Fri, 1 Oct 2021 20:17:42 +0200
Received: from kreacher.localnet (unknown [213.134.175.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 423B066A7A3;
        Fri,  1 Oct 2021 20:17:41 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 3/4] ACPICA: iASL table disassembler: Added disassembly support for the NHLT ACPI table
Date:   Fri, 01 Oct 2021 20:16:25 +0200
Message-ID: <3155545.aeNJFYEL58@kreacher>
In-Reply-To: <2236872.ElGaqSPkdT@kreacher>
References: <2236872.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.164
X-CLIENT-HOSTNAME: 213.134.175.164
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudekiedguddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduieegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 94abe858583de24a425b37cb8e62d56c65c4f3cf

Note: support for Vendor-defined microphone arrays and SNR extensions
are not supported at this time -- mostly due to a lack of example tables.

Actual compiler support for NHLT is forthcoming.

Link: https://github.com/acpica/acpica/commit/94abe858
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 actbl2.h |  250 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 249 insertions(+), 1 deletion(-)

diff -Nurp linux.before_name/include/acpi/actbl2.h linux.after_name/include/acpi/actbl2.h
--- linux.before_name/include/acpi/actbl2.h	2021-10-01 19:32:37.807885990 +0200
+++ linux.after_name/include/acpi/actbl2.h	2021-10-01 19:32:33.714954236 +0200
@@ -35,6 +35,7 @@
 #define ACPI_SIG_MSCT           "MSCT"	/* Maximum System Characteristics Table */
 #define ACPI_SIG_MSDM           "MSDM"	/* Microsoft Data Management Table */
 #define ACPI_SIG_NFIT           "NFIT"	/* NVDIMM Firmware Interface Table */
+#define ACPI_SIG_NHLT           "NHLT"	/* Non HD Audio Link Table */
 #define ACPI_SIG_PCCT           "PCCT"	/* Platform Communications Channel Table */
 #define ACPI_SIG_PDTT           "PDTT"	/* Platform Debug Trigger Table */
 #define ACPI_SIG_PHAT           "PHAT"	/* Platform Health Assessment Table */
@@ -46,7 +47,6 @@
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
-#define ACPI_SIG_NHLT           "NHLT"	/* Non-HDAudio Link Table */
 #define ACPI_SIG_SVKL           "SVKL"	/* Storage Volume Key Location Table */
 
 /*
@@ -1412,6 +1412,254 @@ struct nfit_device_handle {
 
 /*******************************************************************************
  *
+ * NHLT - Non HD Audio Link Table
+ *
+ * Conforms to: Intel Smart Sound Technology NHLT Specification
+ * Version 0.8.1, January 2020.
+ *
+ ******************************************************************************/
+
+/* Main table */
+
+struct acpi_table_nhlt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u8 endpoint_count;
+};
+
+struct acpi_nhlt_endpoint {
+	u32 descriptor_length;
+	u8 link_type;
+	u8 instance_id;
+	u16 vendor_id;
+	u16 device_id;
+	u16 revision_id;
+	u32 subsystem_id;
+	u8 device_type;
+	u8 direction;
+	u8 virtual_bus_id;
+};
+
+/* Types for link_type field above */
+
+#define ACPI_NHLT_RESERVED_HD_AUDIO         0
+#define ACPI_NHLT_RESERVED_DSP              1
+#define ACPI_NHLT_PDM                       2
+#define ACPI_NHLT_SSP                       3
+#define ACPI_NHLT_RESERVED_SLIMBUS          4
+#define ACPI_NHLT_RESERVED_SOUNDWIRE        5
+#define ACPI_NHLT_TYPE_RESERVED             6	/* 6 and above are reserved */
+
+/* All other values above are reserved */
+
+/* Values for device_id field above */
+
+#define ACPI_NHLT_PDM_DMIC                  0xAE20
+#define ACPI_NHLT_BT_SIDEBAND               0xAE30
+#define ACPI_NHLT_I2S_TDM_CODECS            0xAE23
+
+/* Values for device_type field above */
+
+/* SSP Link */
+
+#define ACPI_NHLT_LINK_BT_SIDEBAND          0
+#define ACPI_NHLT_LINK_FM                   1
+#define ACPI_NHLT_LINK_MODEM                2
+/* 3 is reserved */
+#define ACPI_NHLT_LINK_SSP_ANALOG_CODEC     4
+
+/* PDM Link */
+
+#define ACPI_NHLT_PDM_ON_CAVS_1P8           0
+#define ACPI_NHLT_PDM_ON_CAVS_1P5           1
+
+/* Values for Direction field above */
+
+#define ACPI_NHLT_DIR_RENDER                0
+#define ACPI_NHLT_DIR_CAPTURE               1
+#define ACPI_NHLT_DIR_RENDER_LOOPBACK       2
+#define ACPI_NHLT_DIR_RENDER_FEEDBACK       3
+#define ACPI_NHLT_DIR_RESERVED              4	/* 4 and above are reserved */
+
+struct acpi_nhlt_device_specific_config {
+	u32 capabilities_size;
+	u8 virtual_slot;
+	u8 config_type;
+};
+
+struct acpi_nhlt_device_specific_config_a {
+	u32 capabilities_size;
+	u8 virtual_slot;
+	u8 config_type;
+	u8 array_type;
+};
+
+/* Values for Config Type above */
+
+#define ACPI_NHLT_TYPE_MIC_ARRAY            0x01
+#define ACPI_NHLT_TYPE_GENERIC              0x00
+
+/* Mask for Extension field of array_type */
+
+#define ACPI_NHLT_ARRAY_TYPE_MASK           0x10
+
+struct acpi_nhlt_device_specific_config_b {
+	u32 capabilities_size;
+};
+
+struct acpi_nhlt_device_specific_config_c {
+	u32 capabilities_size;
+	u8 virtual_slot;
+};
+
+struct acpi_nhlt_wave_extensible {
+	u16 format_tag;
+	u16 channel_count;
+	u32 samples_per_sec;
+	u32 avg_bytes_per_sec;
+	u16 block_align;
+	u16 bits_per_sample;
+	u16 extra_format_size;
+	u16 valid_bits_per_sample;
+	u32 channel_mask;
+	u8 sub_format_guid[16];
+};
+
+/* Values for channel_mask above */
+
+#define ACPI_NHLT_SPKR_FRONT_LEFT             0x1
+#define ACPI_NHLT_SPKR_FRONT_RIGHT            0x2
+#define ACPI_NHLT_SPKR_FRONT_CENTER           0x4
+#define ACPI_NHLT_SPKR_LOW_FREQ               0x8
+#define ACPI_NHLT_SPKR_BACK_LEFT              0x10
+#define ACPI_NHLT_SPKR_BACK_RIGHT             0x20
+#define ACPI_NHLT_SPKR_FRONT_LEFT_OF_CENTER   0x40
+#define ACPI_NHLT_SPKR_FRONT_RIGHT_OF_CENTER  0x80
+#define ACPI_NHLT_SPKR_BACK_CENTER            0x100
+#define ACPI_NHLT_SPKR_SIDE_LEFT              0x200
+#define ACPI_NHLT_SPKR_SIDE_RIGHT             0x400
+#define ACPI_NHLT_SPKR_TOP_CENTER             0x800
+#define ACPI_NHLT_SPKR_TOP_FRONT_LEFT         0x1000
+#define ACPI_NHLT_SPKR_TOP_FRONT_CENTER       0x2000
+#define ACPI_NHLT_SPKR_TOP_FRONT_RIGHT        0x4000
+#define ACPI_NHLT_SPKR_TOP_BACK_LEFT          0x8000
+#define ACPI_NHLT_SPKR_TOP_BACK_CENTER        0x10000
+#define ACPI_NHLT_SPKR_TOP_BACK_RIGHT         0x20000
+
+struct acpi_nhlt_format_config {
+	struct acpi_nhlt_wave_extensible format;
+	u32 capability_size;
+	u8 capabilities[];
+};
+
+struct acpi_nhlt_formats_config {
+	u8 formats_count;
+};
+
+struct acpi_nhlt_device_specific_hdr {
+	u8 virtual_slot;
+	u8 config_type;
+};
+
+/* Types for config_type above */
+
+#define ACPI_NHLT_GENERIC                   0
+#define ACPI_NHLT_MIC                       1
+#define ACPI_NHLT_RENDER                    3
+
+struct acpi_nhlt_mic_device_specific_config {
+	struct acpi_nhlt_device_specific_hdr device_config;
+	u8 array_type_ext;
+};
+
+/* Values for array_type_ext above */
+
+#define SMALL_LINEAR_2ELEMENT               0x0A
+#define BIG_LINEAR_2ELEMENT                 0x0B
+#define FIRST_GEOMETRY_LINEAR_4ELEMENT      0x0C
+#define PLANAR_LSHAPED_4ELEMENT             0x0D
+#define SECOND_GEOMETRY_LINEAR_4ELEMENT     0x0E
+#define VENDOR_DEFINED                      0x0F
+#define ARRAY_TYPE_MASK                     0x0F
+#define ARRAY_TYPE_EXT_MASK                 0x10
+
+#define NO_EXTENSION                        0x0
+#define MIC_SNR_SENSITIVITY_EXT             0x1
+
+struct acpi_nhlt_vendor_mic_config {
+	u8 type;
+	u8 panel;
+	u16 speaker_position_distance;	// mm
+	u16 horizontal_offset;	// mm
+	u16 vertical_offset;	// mm
+	u8 frequency_low_band;	// 5*hz
+	u8 frequency_high_band;	// 500*hz
+	u16 direction_angle;	// -180 - + 180
+	u16 elevation_angle;	// -180 - + 180
+	u16 work_vertical_angle_begin;	// -180 - + 180 with 2 deg step
+	u16 work_vertical_angle_end;	// -180 - + 180 with 2 deg step
+	u16 work_horizontal_angle_begin;	// -180 - + 180 with 2 deg step
+	u16 work_horizontal_angle_end;	// -180 - + 180 with 2 deg step
+};
+
+/* Values for Type field above */
+
+#define MIC_OMNIDIRECTIONAL                 0
+#define MIC_SUBCARDIOID                     1
+#define MIC_CARDIOID                        2
+#define MIC_SUPER_CARDIOID                  3
+#define MIC_HYPER_CARDIOID                  4
+#define MIC_8_SHAPED                        5
+#define MIC_VENDOR_DEFINED                  7
+
+/* Values for Panel field above */
+
+#define MIC_TOP                             0
+#define MIC_BOTTOM                          1
+#define MIC_LEFT                            2
+#define MIC_RIGHT                           3
+#define MIC_FRONT                           4
+#define MIC_REAR                            5
+
+struct acpi_nhlt_vendor_mic_device_specific_config {
+	struct acpi_nhlt_mic_device_specific_config mic_array_device_config;
+	u8 number_of_microphones;
+	struct acpi_nhlt_vendor_mic_config mic_config[];	// indexed by number_of_microphones
+};
+
+/* Microphone SNR and Sensitivity extension */
+
+struct acpi_nhlt_mic_snr_sensitivity_extension {
+	u32 SNR;
+	u32 sensitivity;
+};
+
+struct acpi_nhlt_render_feedback_device_specific_config {
+	struct acpi_nhlt_device_specific_config device_config;
+	u8 feedback_virtual_slot;	// render slot in case of capture
+	u16 feedback_channels;	// informative only
+	u16 feedback_valid_bits_per_sample;
+};
+
+/* Linux-specific structures */
+
+struct acpi_nhlt_linux_specific_count {
+	u8 structure_count;
+};
+
+struct acpi_nhlt_linux_specific_data {
+	u8 device_id[16];
+	u8 device_instance_id;
+	u8 device_port_id;
+	u8 filler[18];
+};
+
+struct acpi_nhlt_table_terminator {
+	u32 terminator_value;
+	u32 terminator_signature;
+};
+
+/*******************************************************************************
+ *
  * PCCT - Platform Communications Channel Table (ACPI 5.0)
  *        Version 2 (ACPI 6.2)
  *



